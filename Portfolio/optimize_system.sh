#!/bin/bash
set -euo pipefail

echo "=========================================================="
echo "🚀 Iniciando Otimização do Sistema Debian 13 (Trixie)"
echo "=========================================================="

if [ "$EUID" -ne 0 ]; then
  echo "❌ Este script deve ser executado como root (use sudo)."
  exit 1
fi

# 1. Instalação de pacotes necessários
echo "📦 1/6. Instalando pacotes de otimização..."
apt-get update -qq
apt-get install -y -qq zram-tools tlp tlp-rdw thermald lm-sensors earlyoom > /dev/null

# 2. Configuração do GRUB (Boot Rápido)
echo "⚡ 2/6. Otimizando GRUB (removendo delay)..."
sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=1/' /etc/default/grub
if grep -q "^GRUB_TIMEOUT_STYLE=" /etc/default/grub; then
  sed -i 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/' /etc/default/grub
else
  echo 'GRUB_TIMEOUT_STYLE=hidden' >> /etc/default/grub
fi
if ! grep -q "^GRUB_RECORDFAIL_TIMEOUT=" /etc/default/grub; then
  echo 'GRUB_RECORDFAIL_TIMEOUT=0' >> /etc/default/grub
fi
update-grub

# 3. Configuração do ZRAM (Compressão de RAM em tempo real)
echo "🧠 3/6. Configurando ZRAM (RAM comprimida)..."
cat << 'EOF' > /etc/default/zram-tools
ALGORITHM=zstd
PERCENT=60
PRIORITY=100
EOF
systemctl restart zramswap.service || service zramswap restart || true

# 4. Kernel & Sysctl Tuning (RAM, Swap, Cache, BBR)
echo "🎛️ 4/6. Aplicando ajustes de Kernel e Memória..."
cat << 'EOF' > /etc/sysctl.d/99-performance-optimization.conf
# Otimização de RAM e Swap para ZRAM
vm.swappiness = 180
vm.vfs_cache_pressure = 50
vm.dirty_background_ratio = 5
vm.dirty_ratio = 10
vm.max_map_count = 262144

# Otimização de Rede e Latência (Google BBR)
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
EOF
sysctl --system > /dev/null

# 5. Otimização do NVMe (fstab + TRIM)
echo "💾 5/6. Otimizando NVMe SSD (noatime, commit=60 e TRIM)..."
cp /etc/fstab /etc/fstab.bak.$(date +%F_%H%M%S)

# Adiciona noatime,lazytime,commit=60 à partição raiz ext4 se ainda não possuir noatime
if grep -E '\s/\s+ext4\s+' /etc/fstab | grep -v 'noatime' > /dev/null; then
  sed -i -E 's/(\s/\s+ext4\s+)(\S+)/\1\2,noatime,lazytime,commit=60/' /etc/fstab
fi
systemctl enable --now fstrim.timer

# 6. Gerenciamento de Bateria, Fan e Proteção Anti-Freeze
echo "🔋 6/6. Configurando TLP, thermald e earlyoom..."
# Desativa o power-profiles-daemon para evitar conflito com TLP
systemctl disable --now power-profiles-daemon || true
systemctl enable --now tlp
systemctl enable --now thermald
systemctl enable --now earlyoom

echo "=========================================================="
echo "✅ Otimização concluída com sucesso!"
echo "=========================================================="
