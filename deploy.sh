#!/bin/bash
set -e

# --- Configurações ---
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOTAL_STEPS=4

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

# ETAPA 1: Dependências, Assets e Banco
print_header "1" "Atualização de Dependências, Assets e Banco de Dados"

echo -e "${YELLOW}📦 Instalando dependências (Gems)...${NC}"
bundle config set --local without 'development test'
bundle install --quiet

echo -e "${YELLOW}🔨 Compilando Assets do Rails (Tailwind, JS, Imagens)...${NC}"
RAILS_ENV=production bundle exec rails assets:precompile

echo -e "${YELLOW}🗄️ Executando Migrations de Banco de Dados...${NC}"
RAILS_ENV=production bundle exec rails db:migrate

# ETAPA 2: Limpeza
print_header "2" "Limpeza de Cache"

echo -e "${YELLOW}🧹 Limpando cache do Rails...${NC}"
RAILS_ENV=production bundle exec rails tmp:cache:clear 2>/dev/null || true

# ETAPA 3: Reinício
print_header "3" "Reinício do Servidor Puma"

echo -e "${CYAN}🔄 Reiniciando serviço puma-yorrany.service...${NC}"
sudo systemctl restart puma-yorrany.service

# ETAPA 4: Cloudflare
print_header "4" "Limpeza de Cache Cloudflare"

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
