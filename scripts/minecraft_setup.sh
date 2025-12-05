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
    except Exception as e:
        print(f"✗ {name} - NÃO ENCONTRADO: {str(e)}")
        all_ok = False

if not all_ok:
    print("\n⚠️  Instalando dependências faltantes...")
    import subprocess
    subprocess.run([sys.executable, "-m", "pip", "install", "--upgrade", "gymnasium", "stable-baselines3", "torch", "opencv-python"], check=False)
    sys.exit(1)
EOF

RESULT=$?
if [ $RESULT -ne 0 ]; then
    echo -e "${RED}✗ Erro ao verificar/instalar dependências base${NC}"
    exit 1
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

# Tentar importar MineRL
minerl_available = False
try:
    import minerl
    minerl_available = True
    print(f"✓ MineRL já instalado!")
    print(f"  Versão: {minerl.__version__ if hasattr(minerl, '__version__') else 'dev'}")
except ImportError:
    print(f"ℹ️  MineRL não está instalado")
    print(f"   Tentando instalar...")
    
    try:
        # Tentar instalar MineRL
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
    except subprocess.TimeoutExpired:
        print(f"⚠️  Instalação de MineRL expirou (muito lento)")
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
    envs = [
        "MineRLNavigate-v0",
        "MineRLObtainDiamond-v0",
        "MineRLBasaltFindCave-v0"
    ]
    for env in envs:
        print(f"    - {env}")
else:
    print(f"\n✓ Use Gymnasium ambientes para treinar!")
EOFML

RESULT=$?
if [ $RESULT -ne 0 ]; then
    echo -e "${YELLOW}⚠️  Alguns ambientes podem não estar disponíveis${NC}"
    echo -e "${YELLOW}   Mas o sistema pode funcionar com Gymnasium${NC}"
    # Não falhar completamente
fi

trap - EXIT
echo ""
echo -e "${GREEN}✓ Setup concluído!${NC}"
exit 0
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
