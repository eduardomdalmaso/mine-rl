#!/bin/bash
# Mine-RL Quick Start - Inicia o agente visual rapidamente
# Use este script para rodar o agente com um comando

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

# Cores
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}======================================"
echo "   Mine-RL - Quick Start"
echo "=====================================${NC}"
echo ""

# Verificar se venv existe
if [ ! -d "venv" ]; then
    echo -e "${YELLOW}⚠️  Ambiente virtual não encontrado!${NC}"
    echo "Execute primeiro: bash scripts/complete_setup.sh"
    exit 1
fi

# Ativar venv
source venv/bin/activate

echo -e "${GREEN}✓ Ambiente ativado${NC}"
echo ""
echo -e "${BLUE}Menu de Opções:${NC}"
echo ""
echo "1) Testar ambiente (CartPole)"
echo "2) Ver agente em tempo real"
echo "3) Gravar gameplay em vídeo"
echo "4) Verificar setup Minecraft"
echo "5) Treinar agente"
echo "6) Sair"
echo ""

read -p "Escolha uma opção (1-6): " option

case $option in
    1)
        echo -e "${BLUE}Testando ambiente...${NC}"
        python test_env.py
        ;;
    2)
        echo -e "${BLUE}Iniciando visualização em tempo real...${NC}"
        python visual_agent.py
        ;;
    3)
        echo -e "${BLUE}Gravando gameplay...${NC}"
        read -p "Nome do arquivo (padrão: agent_gameplay.mp4): " filename
        filename=${filename:-agent_gameplay.mp4}
        python -c "
from visual_agent import VisualMinecraftAgent
agent = VisualMinecraftAgent('CartPole-v1', render=False)
agent.create_environment()
agent.create_model()
agent.render_rgb_array(num_steps=500, output_video='$filename')
print(f'✓ Vídeo salvo: $filename')
"
        ;;
    4)
        echo -e "${BLUE}Verificando setup Minecraft...${NC}"
        python minecraft_viewer.py
        ;;
    5)
        echo -e "${BLUE}Iniciando treinamento...${NC}"
        read -p "Quantos steps? (padrão: 50000): " steps
        steps=${steps:-50000}
        python -c "
from agent_minecraft import MinecraftAgent
agent = MinecraftAgent()
agent.create_environment()
agent.create_model()
agent.train(total_timesteps=$steps)
agent.save_model()
print('✓ Treinamento concluído!')
"
        ;;
    6)
        echo -e "${GREEN}Até logo!${NC}"
        exit 0
        ;;
    *)
        echo -e "${YELLOW}Opção inválida!${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}✓ Feito!${NC}"
