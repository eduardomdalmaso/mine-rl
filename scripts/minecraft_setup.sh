#!/bin/bash
# Mine-RL Minecraft Setup - Instala e configura MineRL + Minecraft 1.12.2
# Execute este script após complete_setup.sh

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}======================================"
echo "   Mine-RL - Minecraft Setup"
echo "=====================================${NC}"
echo ""

# Verificar se venv existe
if [ ! -d "venv" ]; then
    echo -e "${RED}✗ Ambiente virtual não encontrado!${NC}"
    echo "Execute primeiro: bash scripts/complete_setup.sh"
    exit 1
fi

# Ativar venv
source venv/bin/activate

# Verificar dependências
echo -e "${BLUE}[1/4] Verificando dependências...${NC}"
python << 'EOF'
import sys
try:
    import gymnasium
    print("✓ Gymnasium OK")
except:
    print("✗ Gymnasium não instalado")
    sys.exit(1)

try:
    import stable_baselines3
    print("✓ Stable-Baselines3 OK")
except:
    print("✗ Stable-Baselines3 não instalado")
    sys.exit(1)

try:
    import torch
    print("✓ PyTorch OK")
except:
    print("✗ PyTorch não instalado")
    sys.exit(1)
EOF

# Instalar MineRL
echo -e "${BLUE}[2/4] Instalando MineRL...${NC}"
pip install --upgrade setuptools wheel
pip install minerl --no-cache-dir || {
    echo -e "${YELLOW}⚠️  MineRL precisou de ajustes, tentando novamente...${NC}"
    pip install --upgrade setuptools
    pip install minerl --no-build-isolation
}

# Verificar MineRL
echo -e "${BLUE}[3/4] Verificando MineRL...${NC}"
python << 'EOF'
try:
    import minerl
    print(f"✓ MineRL {minerl.__version__} instalado")
except Exception as e:
    print(f"✗ Erro ao verificar MineRL: {e}")
    import sys
    sys.exit(1)
EOF

# Download de Minecraft (primeiro uso)
echo -e "${BLUE}[4/4] Preparando Minecraft 1.12.2...${NC}"
echo -e "${YELLOW}Isto pode levar alguns minutos na primeira execução${NC}"
echo -e "${YELLOW}(MineRL vai baixar ~2GB de arquivos)${NC}"
echo ""

python << 'EOF'
import minerl
print("✓ MineRL pronto!")
print("✓ Minecraft 1.12.2 será baixado na primeira execução")
EOF

echo ""
echo -e "${GREEN}======================================"
echo "   Setup Minecraft Concluído!"
echo "=====================================${NC}"
echo ""
echo -e "${BLUE}Agora você pode:${NC}"
echo ""
echo "1. Testar com:"
echo -e "   ${YELLOW}python visual_agent.py${NC}"
echo ""
echo "2. Ou usar o menu interativo:"
echo -e "   ${YELLOW}bash scripts/run.sh${NC}"
echo ""
echo -e "${YELLOW}Primeira execução vai baixar Minecraft 1.12.2${NC}"
echo -e "${GREEN}✓ Tudo pronto!${NC}"
