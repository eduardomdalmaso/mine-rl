#!/bin/bash
# Mine-RL Complete Setup - Setup completo e automático
# Instala tudo que precisa para treinar agentes no Minecraft

set -e

echo "======================================"
echo "   Mine-RL - Complete Setup"
echo "======================================"
echo ""

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. Verificar Python
echo -e "${BLUE}[1/5] Verificando Python 3.12...${NC}"
if ! command -v python3.12 &> /dev/null; then
    echo -e "${YELLOW}⚠️  Python 3.12 não encontrado. Usando python3...${NC}"
    PYTHON=python3
else
    PYTHON=python3.12
fi
$PYTHON --version

# 2. Criar venv se não existir
echo -e "${BLUE}[2/5] Configurando ambiente virtual...${NC}"
if [ ! -d "venv" ]; then
    $PYTHON -m venv venv
    echo -e "${GREEN}✓ Ambiente virtual criado${NC}"
else
    echo -e "${GREEN}✓ Ambiente virtual já existe${NC}"
fi

# 3. Ativar venv
echo -e "${BLUE}[3/5] Ativando venv...${NC}"
source venv/bin/activate

# 4. Instalar dependências
echo -e "${BLUE}[4/5] Instalando dependências (isso pode levar alguns minutos)...${NC}"
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt

# 5. Instalar MineRL (opcional, pergunta ao usuário)
echo -e "${BLUE}[5/5] Instalando MineRL...${NC}"
read -p "Deseja instalar MineRL para Minecraft? (s/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
    pip install minerl
    echo -e "${GREEN}✓ MineRL instalado${NC}"
    echo -e "${YELLOW}⚠️  Nota: MineRL vai baixar Minecraft 1.12.2 na primeira execução${NC}"
else
    echo -e "${YELLOW}⊘ MineRL não instalado${NC}"
fi

echo ""
echo -e "${GREEN}======================================"
echo "   Setup Completo!"
echo "=====================================${NC}"
echo ""
echo -e "${BLUE}Próximos passos:${NC}"
echo ""
echo "1. Ativar venv:"
echo -e "   ${YELLOW}source venv/bin/activate${NC}"
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
