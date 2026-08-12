## Descrição do Objetivo
O objetivo é criar uma aplicação monolítica em **Ruby on Rails** do zero, utilizando **ERB** e **Tailwind CSS** para o frontend. O projeto deve incluir um painel de controle (CMS/Cockpit) robusto para gerenciar todo o conteúdo do site (estudos de caso, certificados, etc.) sem a necessidade de edições manuais. O ambiente de produção não utilizará Docker ("zero docker") e será hospedado e configurado diretamente para responder pelo domínio `yorrany.com.br`. Faremos a conversão do design extraído no formato JSON para configurarmos a identidade visual do Tailwind.

## Revisão do Usuário Necessária
> [!IMPORTANT]
> **Escolha do CMS:** Para o painel administrativo nativo em Rails, o **Avo** ou o **Administrate** são excelentes. O Avo, em especial, oferece uma interface super moderna que combina muito bem com o seu design premium. Podemos prosseguir com o Avo?
>
> **Banco de Dados:** A stack padrão será Ruby on Rails com **PostgreSQL**. Confirme se o PostgreSQL está disponível ou deve ser instalado no servidor.

## Perguntas Abertas
> [!WARNING]
> 1. Além de Estudos de Caso, Certificações, Experiências e Formação Acadêmica, existe mais algum conteúdo que precise ser gerenciado pelo Cockpit?

## Alterações Propostas

### 1. Inicialização do Projeto e Banco de Dados
Criação de um novo projeto Rails focado em simplicidade, sem dependências de frameworks JS pesados, garantindo autonomia total.

#### [NEW] Aplicação Rails
- Criação de um projeto Rails com Tailwind CSS nativo (`rails new . -c tailwind -d postgresql`).
- Configuração do `tailwind.config.js` mapeando os tokens de design extraídos do arquivo `extracted_design.json` (paleta de cores, tipografia, espaçamentos).

### 2. Modelagem de Dados e Internacionalização (I18n)
O site público suportará três idiomas: **Português (PT)** com bandeira de Portugal, **Inglês (EN)** com bandeira britânica, e **Espanhol (ES)** com bandeira espanhola. Usaremos a gem `mobility` (ou similar) para traduzir colunas no banco de dados.

#### [NEW] Models e Traduções
- `CaseStudy`: Para gerenciar os cases de sucesso (título, resumo, tags, etc. - traduzíveis).
- `Certification`: Para gerenciar cursos e certificados (traduzíveis).
- `ExperienceItem`: Para gerenciar o histórico profissional (traduzíveis).
- `AcademicBackground`: Para dados de formação (traduzíveis).
- `SiteSetting`: Para gerenciar textos estáticos, links sociais, etc. (traduzíveis).

### 3. Construção do Painel Administrativo (Cockpit)
Implementação da área restrita (`/admin`) para gestão de conteúdo. Esta área será 100% em português (pt-BR) e com acesso restrito.

#### [NEW] CMS Dashboard e Segurança (Turnstile)
- Instalação e configuração do CMS (Avo).
- Configuração do locale do Avo para `pt-BR`.
- Geração de Dashboards CRUD para instâncias de Cases, Certificados, Experiências, etc.
- Implementação de autenticação tradicional (Login e Senha) via **Devise** ou autenticação nativa do Rails 8.
- Integração do **Cloudflare Turnstile** nas telas de login do Cockpit para proteger contra bots e ataques de força bruta, garantindo segurança máxima sem depender do Google.

### 4. Construção das Views (Frontend ERB)
Recriaremos as telas do portfólio utilizando apenas as tecnologias padrão do Rails.

#### [NEW] Views e Componentes
- Criação de partials (`app/views/home/index.html.erb`, `_hero.html.erb`, `_bento_grid.html.erb`) construídos puramente com ERB + Tailwind CSS.
- O site fará consultas diretas ao banco de dados no Controller, repassando as instâncias para as views.
- Estilização premium baseada na estética do design extraído.

### 5. Configuração de Servidor e Domínio (Zero Docker com Cloudflare)
O deploy será realizado nativamente no servidor Linux e gerenciado via Cloudflare.

#### [NEW] Web Server, App Server e DNS
- Instalação/Configuração do **Nginx** como proxy reverso.
- Configuração do **Puma** ou **Passenger** para rodar a aplicação Ruby.
- Configuração de DNS do domínio `yorrany.com.br` diretamente no **Cloudflare**, garantindo proteção DDoS, proxy reverso global e cache na borda.
- Os certificados SSL serão emitidos e gerenciados automaticamente pela Cloudflare (Edge Certificates) ou gerados localmente no servidor via Let's Encrypt (Certbot) com Cloudflare em modo Full (Strict).
- Configuração do Systemd para manter a aplicação online.

---

## Plano de Verificação

### Testes Automatizados
- Executar testes unitários do Rails (`rails test`) garantindo que as models salvam e leem os dados corretamente.

### Verificação Manual
1. Acessar `yorrany.com.br/admin` e criar um novo *Case Study*.
2. Navegar para a página inicial `yorrany.com.br` e verificar se a view em ERB exibe os novos dados de forma responsiva.
3. Validar se a tipografia e cores aplicadas via Tailwind refletem o `extracted_design.json`.
4. Validar se o certificado SSL (cadeado verde) está ativado no domínio.
