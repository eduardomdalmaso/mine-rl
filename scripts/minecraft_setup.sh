#!/bin/bash
# Mine-RL Minecraft Setup - Instala MineRL do repositório oficial do GitHub
# Recomendação do site oficial: https://minerl.readthedocs.io/en/latest/tutorials/index.html

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}======================================"
echo "   Mine-RL - Minecraft Setup (Official GitHub)"
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

# Verificar Java
echo -e "${BLUE}[2/4] Verificando Java 8+...${NC}"
if ! command -v java &> /dev/null; then
    echo -e "${RED}✗ Java não encontrado!${NC}"
    echo -e "${YELLOW}Instale Java 8:${NC}"
    echo "  Ubuntu/Debian: sudo apt-get install openjdk-8-jdk"
    echo "  macOS: brew install --cask adoptopenjdk8"
    echo "  Windows: https://www.oracle.com/java/technologies/downloads/#java8-windows"
    exit 1
fi

java_version=$(java -version 2>&1 | head -1)
echo -e "${GREEN}✓ Java: $java_version${NC}"

# Instalar MineRL do GitHub (versão mais recente)
echo -e "${BLUE}[3/4] Instalando MineRL do GitHub (versão mais recente)...${NC}"
echo -e "${YELLOW}Isto pode levar alguns minutos...${NC}"

pip install git+https://github.com/minerllabs/minerl || {
    echo -e "${YELLOW}⚠️  Tentando com --user flag...${NC}"
    pip install git+https://github.com/minerllabs/minerl --user
}

# Verificar MineRL
echo -e "${BLUE}[4/4] Verificando MineRL...${NC}"
python << 'EOF'
try:
    import minerl
    print(f"✓ MineRL instalado com sucesso!")
    print(f"  Versão: {minerl.__version__ if hasattr(minerl, '__version__') else 'dev'}")
    
    # Listar ambientes disponíveis
    print("\n✓ Ambientes disponíveis:")
    envs = [
        "MineRLNavigate-v0",
        "MineRLNavigateDense-v0", 
        "MineRLObtainDiamond-v0",
        "MineRLObtainDiamondDense-v0",
        "MineRLBasaltFindCave-v0",
        "MineRLBasaltCreateVillageAnimalPen-v0",
        "MineRLBasaltBuildVillageHouse-v0",
        "MineRLBasaltMakeWaterfall-v0"
    ]
    for env in envs[:3]:
        print(f"  - {env}")
    print(f"  ... e mais {len(envs)-3}")
    
except Exception as e:
    print(f"✗ Erro ao verificar MineRL: {e}")
    print("Tente: pip install git+https://github.com/minerllabs/minerl --force-reinstall")
    import sys
    sys.exit(1)
EOF

echo ""
echo -e "${GREEN}======================================"
echo "   Setup Minecraft Concluído!"
echo "=====================================${NC}"
echo ""
echo -e "${BLUE}Próximo passo:${NC}"
echo -e "  ${YELLOW}bash scripts/run.sh${NC}"
echo ""
echo -e "${YELLOW}Nota: MineRL vai baixar ~2GB na primeira execução${NC}"
echo -e "${GREEN}✓ Tudo pronto!${NC}"
