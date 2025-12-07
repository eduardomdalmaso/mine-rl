#!/bin/bash
# Mine-RL Minecraft Setup - Configuração de Ambientes Minecraft
# Com suporte para MineRL (quando disponível) e Gymnasium como fallback

# Não usar 'set -e' para permitir melhor tratamento de erros
trap 'echo -e "\n${RED}Erro: Script interrompido${NC}"; exit 1' EXIT

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}======================================"
echo "   Mine-RL - Minecraft Environment Setup (Conda)"
echo "=====================================${NC}"
echo ""

# Verificar se ambiente conda 'minerl' existe
if ! conda info --envs | grep -q "^minerl"; then
    echo -e "${YELLOW}⚠️  Ambiente conda 'minerl' não encontrado!${NC}"
    echo "Criando ambiente conda 'minerl' com Python 3.8..."
    conda create -y -n minerl python=3.8
fi

# Ativar ambiente conda
eval "$(conda shell.bash hook)"
conda activate minerl

echo -e "${GREEN}✓ Ambiente conda 'minerl' ativado${NC}"
echo ""

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
    except Exception as e:
        print(f"✗ {name} - NÃO ENCONTRADO: {str(e)}")
        all_ok = False

if not all_ok:
    sys.exit(1)
EOF

RESULT=$?
if [ $RESULT -ne 0 ]; then
    echo -e "${YELLOW}⚠️  Instalando dependências faltantes via conda...${NC}"
    conda install -y -c conda-forge gymnasium stable-baselines3 pytorch opencv
fi

# Verificar Java (opcional mas recomendado)
echo -e "${BLUE}[2/3] Verificando Java (opcional)...${NC}"
if command -v java &> /dev/null; then
    java_version=$(java -version 2>&1 | head -1)
    echo -e "${GREEN}✓ Java: $java_version${NC}"
else
    echo -e "${YELLOW}⚠️  Java não encontrado (MineRL real pode não funcionar)${NC}"
    echo -e "${YELLOW}   Mas você pode treinar com ambientes Gymnasium!${NC}"
fi

# Tentar instalar/verificar MineRL
echo -e "${BLUE}[3/3] Configurando ambientes Minecraft...${NC}"
python << 'EOFML'
import sys
import subprocess

minerl_available = False
try:
    import minerl
    minerl_available = True
    print(f"✓ MineRL já instalado!")
    print(f"  Versão: {getattr(minerl, '__version__', 'dev')}")
except ImportError:
    print(f"ℹ️  MineRL não está instalado")
    print(f"   Tentando instalar via pip...")
    try:
        result = subprocess.run(
            [sys.executable, "-m", "pip", "install", "minerl"],
            capture_output=True,
            text=True,
            timeout=300
        )
        if result.returncode == 0:
            print(f"✓ MineRL instalado com sucesso!")
            minerl_available = True
        else:
            print(f"⚠️  Não foi possível instalar MineRL")
            print(f"   Detalhes: {result.stderr[:200]}")
            print(f"   Continuando com Gymnasium...")
    except Exception as e:
        print(f"⚠️  Erro ao instalar MineRL: {str(e)}")
        print(f"   Continuando com Gymnasium...")

# Verificar Gymnasium
try:
    import gymnasium as gym
    print(f"\n✓ Gymnasium disponível com {len(gym.envs.registry)} ambientes")
    print(f"  Ambientes recomendados para RL:")
    print(f"    - CartPole-v1 (iniciante)")
    print(f"    - MountainCar-v0 (meio)")
    print(f"    - LunarLander-v2 (avançado)")
except Exception as e:
    print(f"✗ Gymnasium não encontrado: {str(e)}")
    sys.exit(1)

if minerl_available:
    print(f"\n✓ Ambientes Minecraft MineRL disponíveis:")
    for env in ["MineRLNavigate-v0","MineRLObtainDiamond-v0","MineRLBasaltFindCave-v0"]:
        print(f"    - {env}")
else:
    print(f"\n✓ Use Gymnasium ambientes para treinar!")
EOFML

trap - EXIT
echo ""
echo -e "${GREEN}✓ Setup concluído!${NC}"
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
