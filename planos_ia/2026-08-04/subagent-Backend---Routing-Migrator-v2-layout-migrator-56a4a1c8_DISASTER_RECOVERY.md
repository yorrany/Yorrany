# Matterna Disaster Recovery

## Quick Recovery Commands

### Check Database Status
```bash
sudo systemctl status postgresql
PGPASSWORD=$(grep POSTGRES_PASSWORD .env | cut -d'=' -f2) psql -U $(grep POSTGRES_USER .env | cut -d'=' -f2) -h 127.0.0.1 -d matterna_development -c "SELECT 1;"
```

### Restart Database
```bash
sudo systemctl restart postgresql
```

### Restart All Services
```bash
sudo systemctl restart postgresql
cd "/run/media/yorrany/HD 500GB/MATTERNA/app" && bin/rails server
```

### Check Logs
```bash
# Database health check logs
tail -f log/db_health_check.log

# Startup logs
tail -f log/startup.log

# PostgreSQL logs
sudo journalctl -u postgresql -f
```

## Automatic Recovery Features

1. **PostgreSQL Auto-Restart**: Configured to restart automatically if it crashes
2. **Database Health Check**: Runs every 5 minutes via cron
3. **Telegram Alerts**: Sends notifications on critical failures
4. **Startup Script**: Ensures services start after system boot

## Environment Variables

All sensitive data is stored in `.env` file. Key variables:
- `POSTGRES_USER`: Database username
- `POSTGRES_PASSWORD`: Database password
- `TELEGRAM_BOT_TOKEN`: For alerts
- `TELEGRAM_CHAT_ID`: Alert recipient

## Emergency Contacts

Check Telegram for automated alerts from the system.
