#!/bin/bash
# Mine-RL Minecraft Setup - Configuração de Ambientes Minecraft
# Com suporte para MineRL (quando disponível) e Gymnasium como fallback

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}======================================"
echo "   Mine-RL - Minecraft Environment Setup"
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

# Verificar dependências base
echo -e "${BLUE}[1/3] Verificando dependências base...${NC}"
python << 'EOF'
import sys
deps = {
    'gymnasium': 'Gymnasium',
    'stable_baselines3': 'Stable-Baselines3',
    'torch': 'PyTorch',
    'cv2': 'OpenCV'
}

all_ok = True
for module, name in deps.items():
    try:
        __import__(module)
        print(f"✓ {name}")
    except:
        print(f"✗ {name} - NÃO ENCONTRADO")
        all_ok = False

if not all_ok:
    sys.exit(1)
EOF

# Verificar Java (opcional mas recomendado)
echo -e "${BLUE}[2/3] Verificando Java (opcional)...${NC}"
if command -v java &> /dev/null; then
    java_version=$(java -version 2>&1 | head -1)
    echo -e "${GREEN}✓ Java: $java_version${NC}"
else
    echo -e "${YELLOW}⚠️  Java não encontrado (MineRL real pode não funcionar)${NC}"
    echo -e "${YELLOW}   Mas você pode treinar com ambientes Gymnasium!${NC}"
fi

# Tentar instalar MineRL
echo -e "${BLUE}[3/3] Configurando ambientes Minecraft...${NC}"
python << 'EOF'
import sys

# Tentar importar MineRL
minerl_available = False
try:
    import minerl
    minerl_available = True
    print(f"✓ MineRL já instalado!")
    print(f"  Versão: {minerl.__version__ if hasattr(minerl, '__version__') else 'dev'}")
except ImportError:
    print(f"ℹ️  MineRL não está instalado (isso é normal)")
    print(f"   Você pode treinar com Gymnasium enquanto aguarda)")

# Verificar Gymnasium
try:
    import gymnasium as gym
    print(f"\n✓ Gymnasium disponível com {len(gym.envs.registry)} ambientes")
    print(f"  Ambientes recomendados para RL:")
    print(f"    - CartPole-v1 (iniciante)")
    print(f"    - MountainCar-v0 (meio)")
    print(f"    - LunarLander-v2 (avançado)")
except:
    print(f"✗ Gymnasium não encontrado!")
    sys.exit(1)

if minerl_available:
    print(f"\n✓ Ambientes Minecraft MineRL disponíveis:")
    envs = [
        "MineRLNavigate-v0",
        "MineRLObtainDiamond-v0",
        "MineRLBasaltFindCave-v0"
    ]
    for env in envs:
        print(f"    - {env}")
EOF

echo ""
echo -e "${GREEN}======================================"
echo "   Setup Concluído!"
echo "=====================================${NC}"
echo ""
echo -e "${BLUE}Você pode agora:${NC}"
echo -e "  1. Treinar com ${YELLOW}Gymnasium${NC} (sempre disponível)"
echo -e "  2. Instalar MineRL para Minecraft real (opcional)"
echo ""
echo -e "${BLUE}Para começar:${NC}"
echo -e "  ${YELLOW}bash scripts/run.sh${NC}"
echo ""
echo -e "${GREEN}✓ Ambiente pronto para treinar agentes RL!${NC}"
echo ""
