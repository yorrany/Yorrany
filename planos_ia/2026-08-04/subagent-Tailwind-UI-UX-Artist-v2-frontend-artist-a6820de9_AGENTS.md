# Memória do Projeto — Matterna Base

## ⚠️ PORTA FIXA: 3000 (NÃO ALTERAR)

Ver `/var/www/app/AGENTS.md` para documentação completa da arquitetura.

---

- **Localização:** `/var/www/app`
- **Porta:** 3000 (produção)
- **Ruby:** 3.3.0 | **Rails:** 8.0.x
- **Banco:** PostgreSQL 16+ (`matterna_production` em `127.0.0.1:5432`)
- **Autenticação:** Clerk (JWT-based)
- **Infraestrutura Nativa:** NUNCA usar Docker sob nenhuma hipótese. Tudo deve rodar e ser implantado de forma 100% nativa na VPS.

## Iniciar produção
O servidor Puma é gerenciado nativamente via **systemd**.
Nunca inicie instâncias manualmente em background (`setsid` ou `&`) para evitar conflito de portas (EADDRINUSE).

```bash
systemctl start puma
systemctl restart puma
systemctl status puma
```

Para deploys, use obrigatoriamente o script:
```bash
./bin/deploy
```
(O script fará o graceful restart via `touch tmp/restart.txt` ou subirá o serviço via `systemctl` se necessário).

### ⚠️ REGRA CRÍTICA DE ATUALIZAÇÃO (DEPLOY)
**SEM DEPLOY NADA ATUALIZA.**
Qualquer alteração feita no projeto (views, controllers, estilos, assets, etc.) **NÃO** refletirá no ambiente de produção até que o deploy seja efetuado. Se você alterar algo no código e o usuário precisar ver as mudanças na versão live, você DEVE rodar o comando `./bin/deploy` e aguardar sua conclusão.
## Regras de Deploy e Testes Automáticos
O script `bin/deploy` precisa de privilégios sudo para reiniciar serviços. A senha de root/sudo está armazenada de forma segura na variável `MACMINI_SUDO_PASSWORD` dentro do arquivo `.env` e é lida automaticamente pelo script.

**LEI DE ROTINA DE TESTES AUTOMÁTICOS (GATEKEEPER):**
Todo deploy pelo `bin/deploy` executa **obrigatoriamente** a suíte de testes (Minitest) local antes de aplicar qualquer alteração. Se um teste falhar, o deploy é imediatamente **BLOQUEADO**.
- Sempre crie testes de integração ao implementar novas lógicas críticas;
- Se estiver ajudando a codar, sempre considere rodar `RAILS_ENV=test bundle exec rails test` antes de disparar o deploy;
- Fixtures globais (`fixtures :all`) foram desativadas por segurança. Use a criação de estado manual se necessário.

## Logs
```bash
# Logs da aplicação Rails:
tail -f /var/www/app/log/production.log

# Logs do servidor web Puma (Systemd Journal):
journalctl -u puma -f
```

## Rotas servidas
- `/` — Homepage
- `/admin/*` — Admin panel (products, brands, categories, blog, users, analytics)
- `/products/*` — Catálogo
- `/brands/*` — Marcas
- `/categories/*` — Categorias
- `/blog/*` — Blog
- `/users/*` — Auth (Clerk)
- `/api/*` — APIs

## Models principais
`User`, `Product`, `Brand`, `Category`, `Partner`, `BlogPost`, `Post`, `Community`, `TrackingEvent`, `HomeBackground`

## Super Admin
- **User ID:** `user_3Eb8GVhxPbxhjhx18i356uDXXha`
- **Email:** yorranymb@gmail.com
- **Privilégio:** Único usuário com acesso à dashboard admin (`/admin`)
- **Definição:** Hardcoded em `app/services/clerk_user.rb` via `SUPER_ADMIN_ID`
- **⚠️ NUNCA** remover ou alterar esse ID sem autorização explícita
