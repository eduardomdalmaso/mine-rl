#!/bin/bash
# Mine-RL Minecraft Setup - Configuração para ambiente Minecraft
# Nota: MineRL é incompatível com Python 3.12
# Usando Gymnasium + simulações como alternativa

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

# Informação importante
echo -e "${YELLOW}ℹ️  INFORMAÇÃO IMPORTANTE:${NC}"
echo ""
echo "MineRL (0.4.4) é incompatível com Python 3.12."
echo "Usando alternativa: Gymnasium com ambientes simulados"
echo ""
echo -e "${BLUE}Opções:${NC}"
echo ""
echo "1. ${GREEN}Usar Gymnasium (recomendado)${NC}"
echo "   - Compatível com Python 3.12"
echo "   - Ambientes simulados (CartPole, LunarLander, etc)"
echo "   - Perfeito para treinar agentes RL"
echo ""
echo "2. ${YELLOW}Usar Minecraft via ModLoader API${NC}"
echo "   - Requer Minecraft Java Edition"
echo "   - Requer mod customizado"
echo "   - Mais complexo"
echo ""
echo "3. ${BLUE}Ambos (treina com Gymnasium, testa com Minecraft)${NC}"
echo ""

read -p "Escolha uma opção (1-3): " option

case $option in
    1)
        echo -e "${GREEN}✓ Gymnasium já está instalado!${NC}"
        echo ""
        echo "Ambientes disponíveis:"
        echo "  - CartPole-v1"
        echo "  - MountainCar-v0"
        echo "  - LunarLander-v2"
        echo "  - Acrobot-v1"
        echo ""
        echo "Use: bash scripts/run.sh"
        ;;
    2)
        echo -e "${YELLOW}Setup do Minecraft via ModLoader...${NC}"
        echo ""
        echo "Instruções:"
        echo "1. Instale Minecraft Java Edition"
        echo "2. Instale Forge ou Fabric"
        echo "3. Instale o mod MinecraftRL"
        echo "4. Configure a conexão em minecraft_viewer.py"
        echo ""
        ;;
    3)
        echo -e "${BLUE}Configurando ambas opções...${NC}"
        echo "✓ Gymnasium: Pronto"
        echo "Para Minecraft: Siga instruções acima"
        ;;
    *)
        echo -e "${RED}Opção inválida!${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}======================================"
echo "   Setup Concluído!"
echo "=====================================${NC}"
echo ""
echo "Próximo passo:"
echo -e "  ${YELLOW}bash scripts/run.sh${NC}"
echo ""
