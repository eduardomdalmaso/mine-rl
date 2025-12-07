#!/bin/bash
# Mine-RL Quick Start - Inicia o agente visual rapidamente (versão conda)
# Se não existir um ambiente conda chamado minerl, cria automaticamente

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

# Cores
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}======================================"
echo "   Mine-RL - Quick Start (Conda)"
echo "=====================================${NC}"
echo ""

# Verificar se ambiente conda 'minerl' existe
if ! conda info --envs | grep -q "^minerl"; then
    echo -e "${YELLOW}⚠️  Ambiente conda 'minerl' não encontrado!${NC}"
    echo "Criando ambiente conda 'minerl' com Python 3.8..."
    conda create --name minerl python=3.8
fi

# Ativar ambiente conda
eval "$(conda shell.bash hook)"
conda activate minerl

echo -e "${GREEN}✓ Ambiente conda 'minerl' ativado${NC}"
echo ""

# Função para verificar se as dependências estão instaladas
check_dependencies() {
    python -c "import minerl" 2>/dev/null
    return $?
}

# Verificar dependências
if ! check_dependencies; then
    echo -e "${YELLOW}⚠️  MineRL não está instalado!${NC}"
    echo ""
    echo "Dependências necessárias para usar agentes no Minecraft:"
    echo "  - MineRL"
    echo "  - Outros requisitos"
    echo ""
    read -p "Deseja instalar as dependências agora? (s/n): " install_choice
    
    if [[ "$install_choice" =~ ^[Ss]$ ]]; then
        echo -e "${BLUE}Executando minecraft_setup.sh...${NC}"
        
        if bash "$SCRIPT_DIR/minecraft_setup.sh"; then
            echo -e "${GREEN}✓ Dependências instaladas com sucesso!${NC}"
        else
            echo -e "${YELLOW}⚠️  Erro durante a instalação das dependências${NC}"
            echo "Tentando reparar..."
            
            # Tentar reinstalar com mais verbosidade
            pip install --upgrade pip setuptools wheel
            pip install minerl --verbose 2>&1 | tee /tmp/minerl_install.log
            
            if check_dependencies; then
                echo -e "${GREEN}✓ MineRL instalado após reparo!${NC}"
            else
                echo -e "${YELLOW}⚠️  Ainda há problemas. Você pode tentar mais tarde.${NC}"
                echo "Log disponível em: /tmp/minerl_install.log"
            fi
        fi
    else
        echo -e "${YELLOW}Operação cancelada. Você pode executar as dependências depois.${NC}"
    fi
    echo ""
fi

echo -e "${BLUE}Menu - Treinamento de Agentes Minecraft:${NC}"
echo ""
echo "1) Treinar agente"
echo "2) Ver agente em tempo real"
echo "3) Gravar gameplay em vídeo"
echo "4) Verificar setup Minecraft"
echo "5) Sair"
echo ""

read -p "Escolha uma opção (1-5): " option

case $option in
    1)
        echo -e "${BLUE}Iniciando treinamento de agente Minecraft...${NC}"
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
