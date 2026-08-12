# Quick Resume - Matterna Project

## Contexto Rápido

O projeto **Matterna** (matterna.com.br) foi migrado de uma VPS KingHost para esta máquina local (Mac Mini).

**Documentação completa:** `/var/www/app/MIGRATION.md`

---

## Informações Essenciais

### Máquina
- **Hostname:** macmini-matterna
- **Usuário:** yorrany
- **Senha sudo:** silvi@Moren@2028
- **IP Local:** 192.168.0.254
- **IP Tailscale:** 100.126.131.112

### Projeto
- **Diretório:** `/var/www/app`
- **Ruby:** 3.3.0 (via rbenv em `~/.rbenv/`)
- **Rails:** 8.0.1
- **Node.js:** 22.x

### Banco de Dados
- **Host:** 127.0.0.1:5432
- **Database:** matterna_production
- **User:** matterna
- **Password:** matterna_dev

### Serviços (systemd)
```bash
sudo systemctl status puma matterna-scraper cloudflared nginx postgresql redis-server
```

### Sites
- https://matterna.com.br ✅
- https://www.matterna.com.br ✅

---

## Para Iniciar Trabalho em Novo Chat

1. Leia `/var/www/app/MIGRATION.md` para contexto completo
2. Leia `/var/www/app/AGENTS.md` para regras do projeto
3. O projeto está funcional e rodando

---

## Comandos Rápidos

```bash
# Acessar o projeto
cd /var/www/app

# Configurar Ruby (se necessário)
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

# Status dos serviços
sudo systemctl status puma cloudflared nginx

# Logs
sudo journalctl -u puma -f

# Console Rails
cd /var/www/app && RAILS_ENV=production bundle exec rails console
```
