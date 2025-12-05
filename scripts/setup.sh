#!/bin/bash
# Setup do ambiente Python para MineRL

echo "🔧 Configurando ambiente MineRL..."

# Criar ambiente virtual
python3 -m venv venv
echo "✓ Ambiente virtual criado"

# Ativar ambiente
source venv/bin/activate
echo "✓ Ambiente virtual ativado"

# Instalar dependências
pip install --upgrade pip
pip install -r requirements.txt
echo "✓ Dependências instaladas"

# Testar instalação
echo ""
echo "🧪 Testando ambiente..."
python test_env.py

echo ""
echo "✅ Setup concluído!"
echo "Para ativar o ambiente: source venv/bin/activate"
