# ═══════════════════════════════════════════════════════════════
# ROTEIRO PARA VÍDEO DE DEMONSTRAÇÃO — PINTEREST API
# ═══════════════════════════════════════════════════════════════
# Este documento contém o passo a passo para gravar a tela
# e solicitar o "Standard Access" (Acesso de Produção)
# ═══════════════════════════════════════════════════════════════

## PREPARAÇÃO ANTES DA GRAVAÇÃO

### 1. Configurar Variáveis de Ambiente
```bash
# No arquivo .env, adicione:
PINTEREST_APP_ID=SEU_APP_ID
PINTEREST_APP_SECRET=SEU_APP_SECRET
PINTEREST_ACCESS_TOKEN=  # Será preenchido automaticamente
```

### 2. Configurar Redirect URI no Pinterest Developer Portal
- Acesse: https://developers.pinterest.com/apps/
- No seu app, adicione a Redirect URI:
  - Produção: `https://matterna.com.br/pinterest/sandbox/callback`
  - Local: `http://localhost:3000/pinterest/sandbox/callback`

### 3. Iniciar o Servidor Local
```bash
cd /run/media/yorrany/HD\ 500GB/MATTERNA/app
rails server
```

---

## ROTEIRO DE GRAVAÇÃO (5-7 minutos)

### CENA 1: Aplicação e Contexto (30 segundos)
**O que mostrar:**
- Abra o site `https://www.matterna.com.br` ou `http://localhost:3000`
- Mostre a homepage brevemente
- Explique: "Este é o Matterna, uma plataforma de maternidade que integra com Pinterest para compartilhar conteúdo"

**Narração sugerida:**
> "O Matterna é uma plataforma dedicada à maternidade real. Para enriquecer a experiência das nossas usuárias, integramos com o Pinterest para permitir login social e compartilhamento de pins."

---

### CENA 2: Fluxo OAuth 2.0 (1.5 minutos)
**O que mostrar:**
1. Acesse `http://localhost:3000/pinterest/sandbox`
2. Clique no botão "Autorizar com Pinterest"
3. **IMPORTANTE:** Mostre a tela de consentimento do Pinterest claramente
4. Autorize o aplicativo
5. Mostre o redirecionamento de volta ao app com a mensagem de sucesso
6. Mostre o token obtido na sidebar

**Narração sugerida:**
> "Iniciamos o fluxo OAuth 2.0 padrão. O usuário clica em 'Autorizar com Pinterest', é redirecionado para a tela de consentimento onde pode revisar os escopos solicitados - boards:read, boards:write, pins:read e pins:write. Após autorizar, o Pinterest retorna um código que trocamos por um access token."

**Checklist de captura:**
- [ ] Tela de consentimento do Pinterest visível
- [ ] Escopos listados claramente
- [ ] Redirecionamento funcionando
- [ ] Mensagem de sucesso aparecendo

---

### CENA 3: Criação de Board (1 minuto)
**O que mostrar:**
1. Na página do Sandbox, localize a seção "Criar Board"
2. Preencha o nome: "Maternidade Real - Matterna"
3. Preencha a descrição
4. Clique em "Criar Board"
5. Mostre o board aparecendo na sidebar "Boards Criados"

**Narração sugerida:**
> "Agora demonstramos a criação de um board através da API. O board é criado via POST para o endpoint /v5/boards do sandbox. O ID retornado é usado para vincular pins."

**Checklist de captura:**
- [ ] Formulário preenchido
- [ ] Requisição sendo feita (pode usar Network tab do DevTools)
- [ ] Board criado com sucesso
- [ ] ID do board visível

---

### CENA 4: Criação de Pin (1.5 minutos)
**O que mostrar:**
1. Na seção "Criar Pin", selecione o board criado
2. Preencha o título: "Rotina Matinal com Bebê"
3. Preencha a descrição com hashtags
4. Adicione o link de destino (URL do Matterna)
5. Use a URL de imagem padrão ou adicione uma
6. Clique em "Criar Pin"
7. Mostre o pin aparecendo na sidebar "Pins Criados"

**Narração sugerida:**
> "Com o board criado, agora podemos adicionar pins. Cada pin é vinculado a um board e contém uma imagem, título, descrição e link de destino. A imagem é enviada via URL no campo media_source da requisição POST para /v5/pins."

**Checklist de captura:**
- [ ] Board selecionado no dropdown
- [ ] Todos os campos preenchidos
- [ ] Requisição POST visível no Network tab
- [ ] Pin criado com sucesso
- [ ] ID do pin visível

---

### CENA 5: Demo Automática (Opcional - 30 segundos)
**O que mostrar:**
1. Clique no botão "Executar Demo"
2. Confirme a ação
3. Mostre os resultados na sidebar

**Narração sugerida:**
> "Para facilitar a demonstração, criamos um fluxo automático que executa todas as operações em sequência: cria um board e três pins com imagens temáticas de maternidade."

---

### CENA 6: Verificação no Pinterest (1 minuto)
**O que mostrar:**
1. Abra `https://pinterest.com` em outra aba
2. Faça login na conta de teste/sandbox
3. Navegue até os boards
4. Mostre o board "Maternidade Real - Matterna" criado
5. Abra o board e mostre os pins criados

**Narração sugerida:**
> "Aqui podemos confirmar que os dados foram realmente criados no Pinterest. O board e os pins aparecem na conta do usuário, prontos para serem visualizados e compartilhados."

**Checklist de captura:**
- [ ] Board visível no Pinterest
- [ ] Pins dentro do board
- [ ] Imagens carregando corretamente
- [ ] Links funcionais

---

## PONTOS-CHAVE PARA APROVAÇÃO

### O que o Pinterest quer ver:
1. **Fluxo OAuth completo** — Tela de consentimento clara
2. **Uso legítimo dos escopos** — Não peça mais do que precisa
3. **Criação de conteúdo** — Boards e Pins sendo criados
4. **Experiência do usuário** — Fluxo natural e intuitivo
5. **Documentação** — Código limpo e bem documentado

### Erros comuns que causam rejeição:
- ❌ Não mostrar a tela de consentimento
- ❌ Pedir escopos desnecessários
- ❌ Não tratar erros adequadamente
- ❌ Código confuso ou sem documentação
- ❌ Não explicar o caso de uso

---

## COMANDOS ÚTEIS PARA DEBUG

```bash
# Verificar se o servidor está rodando
curl http://localhost:3000/health

# Listar boards via rake task
rails pinterest:sandbox:list_boards

# Criar board via CLI
rails pinterest:sandbox:create_board

# Criar pin via CLI
rails pinterest:sandbox:create_pin[BOARD_ID]

# Executar demo completa
rails pinterest:sandbox:demo

# Ver logs em tempo real
tail -f log/development.log
```

---

## ESTRUTURA DE ARQUIVOS CRIADA

```
app/
├── services/
│   └── pinterest_sandbox_service.rb    # Serviço principal do Sandbox
├── controllers/
│   └── pinterest/
│       └── sandbox_controller.rb       # Controller do Sandbox
├── views/
│   └── pinterest/
│       └── sandbox/
│           └── index.html.erb          # Interface do Sandbox
└── lib/
    └── tasks/
        └── pinterest_sandbox.rake      # Tasks CLI
```

---

## ENDPOINTS DO SANDBOX

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/v5/boards` | Lista boards do usuário |
| POST | `/v5/boards` | Cria um novo board |
| GET | `/v5/boards/:id` | Detalhes de um board |
| GET | `/v5/boards/:id/pins` | Pins de um board |
| POST | `/v5/pins` | Cria um novo pin |
| GET | `/v5/pins/:id` | Detalhes de um pin |

**Base URL Sandbox:** `https://api-sandbox.pinterest.com/v5`

---

## CHECKLIST FINAL ANTES DE ENVIAR

- [ ] Vídeo gravado com tela clara
- [ ] Fluxo OAuth completo mostrado
- [ ] Tela de consentimento visível
- [ ] Board criado com sucesso
- [ ] Pin criado com sucesso
- [ ] Dados visíveis no Pinterest
- [ ] Narrativa explicativa incluída
- [ ] Código fonte disponível se solicitado
