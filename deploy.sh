#!/bin/bash
set -e

# --- Configurações ---
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOTAL_STEPS=6

# --- Cores ---
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

function print_header() {
    local step=$1
    local title=$2
    echo -e "\n${CYAN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}▶ [Etapa $step de $TOTAL_STEPS] $title${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

cd "$PROJECT_DIR"

if [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

# ETAPA 0: Qualidade e Segurança
print_header "0" "Validações Locais (Testes, Lint e Segurança)"

echo -e "${YELLOW}🔒 Verificando vulnerabilidades nas dependências (bundle-audit)...${NC}"
bundle exec bundle-audit check --update || { echo -e "${RED}Falha de segurança nas dependências! Abortando.${NC}"; exit 1; }

echo -e "${YELLOW}🕵️‍♂️ Executando análise estática de segurança (Brakeman)...${NC}"
bundle exec brakeman -q -w3 --no-pager || { echo -e "${RED}Falha na análise de segurança do código! Abortando.${NC}"; exit 1; }

echo -e "${YELLOW}🧹 Verificando padronização e Lint (Rubocop)...${NC}"
bundle exec rubocop -A || { echo -e "${RED}Falha no Lint! Corrija os erros antes do deploy.${NC}"; exit 1; }

echo -e "${YELLOW}✅ Executando testes (Rails test)...${NC}"
RAILS_ENV=test bundle exec rails test || { echo -e "${RED}Testes unitários/integração falharam! Abortando.${NC}"; exit 1; }

# ETAPA 1: Git & AI Review
print_header "1" "Revisão Automática com IA e Merge no GitHub"
if [[ -z "$GITHUB_TOKEN" ]]; then
    echo -e "${RED}Erro: GITHUB_TOKEN não está definido. Por favor, adicione ao .env.${NC}"
    exit 1
fi

if [[ -n $(git status --porcelain) ]]; then
    echo -e "${YELLOW}Mudanças locais detectadas. Iniciando processo de PR...${NC}"
    BRANCH="deploy-$(date +%s)"
    
    git checkout -b $BRANCH
    git add .
    git commit -m "Auto deploy changes"
    git push -u origin $BRANCH
    
    echo -e "${YELLOW}Criando Pull Request...${NC}"
    PR_RESPONSE=$(curl -s -X POST -H "Authorization: token $GITHUB_TOKEN" \
      -H "Accept: application/vnd.github.v3+json" \
      https://api.github.com/repos/yorrany/Yorrany/pulls \
      -d "{\"title\":\"Auto Deploy PR\",\"head\":\"$BRANCH\",\"base\":\"main\"}")
      
    PR_NUMBER=$(python3 -c "import sys, json; print(json.load(sys.stdin).get('number', ''))" <<< "$PR_RESPONSE")
    
    if [ -z "$PR_NUMBER" ]; then
        echo -e "${RED}Erro ao criar PR. Abortando.${NC}"
        echo "$PR_RESPONSE"
        git checkout main
        exit 1
    fi
    echo -e "${CYAN}PR #$PR_NUMBER criado.${NC}"
    
    MAX_RETRIES=3
    RETRY_COUNT=0
    APPROVED=false

    while [ $RETRY_COUNT -lt $MAX_RETRIES ] && [ "$APPROVED" = false ]; do
        echo -e "${CYAN}Solicitando avaliação da IA (Tentativa $(($RETRY_COUNT + 1)))...${NC}"
        DIFF_FILE="/tmp/deploy_diff_$(date +%s).txt"
        git diff main..$BRANCH > "$DIFF_FILE"
        
        AI_REVIEW=$(python3 script/ai_reviewer.py "$DIFF_FILE")
        
        if [[ "$AI_REVIEW" == "APROVADO" ]]; then
            echo -e "${GREEN}IA APROVOU o PR! Resultado: $AI_REVIEW${NC}"
            echo -e "${YELLOW}Realizando merge automático...${NC}"
            curl -s -X PUT -H "Authorization: token $GITHUB_TOKEN" \
              -H "Accept: application/vnd.github.v3+json" \
              https://api.github.com/repos/yorrany/Yorrany/pulls/$PR_NUMBER/merge \
              -d "{\"commit_title\":\"Auto merge by AI\",\"merge_method\":\"squash\"}"
              
            git checkout main
            git pull origin main
            git branch -D $BRANCH
            echo -e "${GREEN}Merge concluído com sucesso!${NC}"
            APPROVED=true
        else
            echo -e "${RED}IA REJEITOU o PR! Motivo:${NC}"
            echo "$AI_REVIEW"
            echo -e "${YELLOW}Acionando IA para correção automática...${NC}"
            
            FIX_PROMPT="O deploy foi rejeitado pela pipeline de qualidade. Feedback do revisor: '$AI_REVIEW'. Edite os arquivos necessários para corrigir este problema. Use a tool de edição apropriada. Faça a correção, conclua o que precisa e pare a execução sem pedir aprovação humana."
            agy --dangerously-skip-permissions --mode accept-edits --print "$FIX_PROMPT"
            
            git add .
            git commit -m "Auto-heal fix" || true
            git push origin $BRANCH
            
            RETRY_COUNT=$(($RETRY_COUNT + 1))
            echo -e "${CYAN}Correção da IA enviada pro GitHub. Reiniciando a validação do PR...${NC}"
        fi
    done

    if [ "$APPROVED" = false ]; then
        echo -e "${RED}Falha após $MAX_RETRIES tentativas de correção pela IA. Abortando deploy.${NC}"
        git checkout main
        exit 1
    fi
else
    echo -e "${GREEN}Nenhuma alteração local não-comitada detectada.${NC}"
fi

# ETAPA 2: Dependências, Assets e Banco
print_header "2" "Atualização de Dependências, Assets e Banco de Dados"

echo -e "${YELLOW}📦 Instalando dependências (Gems)...${NC}"
bundle config set --local without 'development test'
bundle install --quiet

echo -e "${YELLOW}🔨 Compilando Assets do Rails (Tailwind, JS, Imagens)...${NC}"
RAILS_ENV=production bundle exec rails assets:precompile

echo -e "${YELLOW}🗄️ Executando Migrations de Banco de Dados...${NC}"
RAILS_ENV=production bundle exec rails db:migrate

# ETAPA 3: Limpeza
print_header "3" "Limpeza de Cache"

echo -e "${YELLOW}🧹 Limpando cache do Rails...${NC}"
RAILS_ENV=production bundle exec rails tmp:cache:clear 2>/dev/null || true

# ETAPA 4: Reinício
print_header "4" "Reinício do Servidor Puma"

echo -e "${CYAN}🔄 Reiniciando serviço puma-yorrany.service...${NC}"
sudo systemctl restart puma-yorrany.service

# ETAPA 5: Cloudflare
print_header "5" "Limpeza de Cache Cloudflare"

if [ -n "$CLOUDFLARE_ZONE_ID" ] && [ -n "$CLOUDFLARE_API_TOKEN" ]; then
    echo -e "${YELLOW}☁️ Limpando cache do Cloudflare...${NC}"
    curl -X POST "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/purge_cache" \
         -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
         -H "Content-Type: application/json" \
         --data '{"purge_everything":true}' --silent
    echo -e "\n${GREEN}Cache do Cloudflare limpo.${NC}"
else
    echo -e "${YELLOW}⚠️ Variáveis CLOUDFLARE_ZONE_ID e CLOUDFLARE_API_TOKEN não definidas. Pulando limpeza de cache da CDN.${NC}"
    echo -e "${YELLOW}💡 Dica: Adicione-as no ambiente ou no arquivo .env para limpar a CDN automaticamente.${NC}"
fi

echo -e "\n${GREEN}${BOLD}🎉 DEPLOY YORRANY CONCLUÍDO COM SUCESSO!${NC}"
echo -e "------------------------------------------------------------"
echo -e "🌎 Site: ${CYAN}https://yorrany.com.br${NC}"
echo -e "⏱️ Hora:  $(date +'%H:%M:%S')"
echo -e "------------------------------------------------------------\n"
