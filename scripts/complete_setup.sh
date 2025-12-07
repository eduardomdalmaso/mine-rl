#!/bin/bash
# Mine-RL Complete Setup - Setup completo e automático (versão conda)
# Instala tudo que precisa para treinar agentes no Minecraft

set -e

echo "======================================"
echo "   Mine-RL - Complete Setup (Conda)"
echo "======================================"
echo ""

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. Verificar se ambiente conda 'minerl' existe
echo -e "${BLUE}[1/5] Verificando ambiente conda 'minerl'...${NC}"
if ! conda info --envs | grep -q "^minerl"; then
    echo -e "${YELLOW}⚠️  Ambiente conda 'minerl' não encontrado. Criando com Python 3.8...${NC}"
    conda create -y -n minerl python=3.8
fi

# 2. Ativar ambiente conda
echo -e "${BLUE}[2/5] Ativando ambiente conda...${NC}"
eval "$(conda shell.bash hook)"
conda activate minerl
echo -e "${GREEN}✓ Ambiente conda 'minerl' ativado${NC}"

# 3. Instalar dependências base
echo -e "${BLUE}[3/5] Instalando dependências base via conda...${NC}"
conda install -y -c conda-forge gymnasium stable-baselines3 pytorch opencv

# 4. Instalar extras do requirements.txt (se existir)
if [ -f "requirements.txt" ]; then
    echo -e "${BLUE}[4/5] Instalando pacotes extras do requirements.txt...${NC}"
    pip install --upgrade pip setuptools wheel
    pip install -r requirements.txt
else
    echo -e "${YELLOW}⚠️  requirements.txt não encontrado, pulando etapa${NC}"
fi

# 5. Instalar MineRL (opcional)
echo -e "${BLUE}[5/5] Instalar MineRL (Minecraft)?${NC}"
read -p "Deseja instalar MineRL para Minecraft? (s/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
    pip install git+https://github.com/minerllabs/minerl
    echo -e "${GREEN}✓ MineRL instalado${NC}"
    echo -e "${YELLOW}⚠️  Nota: MineRL vai baixar Minecraft 1.12.2 na primeira execução${NC}"
else
    echo -e "${YELLOW}⊘ MineRL não instalado${NC}"
fi

echo ""
echo -e "${GREEN}======================================"
echo "   Setup Completo!"
echo "======================================"
echo ""
echo -e "${BLUE}Próximos passos:${NC}"
echo ""
echo "1. Ativar ambiente conda:"
echo -e "   ${YELLOW}conda activate minerl${NC}"
echo ""
echo "2. Testar ambiente:"
echo -e "   ${YELLOW}python test_env.py${NC}"
echo ""
echo "3. Ver agente visual:"
echo -e "   ${YELLOW}python visual_agent.py${NC}"
echo ""
echo "4. Setup do Minecraft:"
echo -e "   ${YELLOW}python minecraft_viewer.py${NC}"
echo ""
echo "5. Treinar agente:"
echo -e "   ${YELLOW}python agent_minecraft.py${NC}"
echo ""
echo -e "${GREEN}✓ Tudo pronto para começar!${NC}"
