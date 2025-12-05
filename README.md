# Mine-RL: Agentes Inteligentes no Minecraft

Ambiente Python para treinar agentes de **Reinforcement Learning** no Minecraft usando MineRL. Este projeto fornece um setup completo para desenvolver e testar agentes inteligentes capazes de realizar tarefas complexas no jogo.

## 🎯 Objetivo

Treinar agentes RL que aprendam a:
- Navegar em ambientes 3D
- Coletar recursos
- Executar tarefas sequenciais
- Interagir com o ambiente do Minecraft

## 🚀 Quick Start

### Instalação

```bash
# Clone o repositório
git clone https://github.com/eduardomdalmaso/mine-rl.git
cd mine-rl

# Configure o ambiente virtual
python3.12 -m venv venv
source venv/bin/activate

# Instale as dependências
pip install -r requirements.txt
```

### Execute o teste
```bash
python test_env.py
```

### Treine um agente
```bash
python agent_minecraft.py
```

## 📦 Dependências

- **gymnasium**: Ambientes RL padronizados
- **stable-baselines3**: Algoritmos RL (PPO, DQN, A2C)
- **torch**: Deep Learning com PyTorch
- **numpy**: Computação numérica
- **opencv-python**: Processamento de imagens
- **minerl**: Ambiente Minecraft para RL (próximas versões)

## 📁 Estrutura

```
mine-rl/
├── agent_minecraft.py      # Agente principal para Minecraft
├── test_env.py             # Script de teste
├── requirements.txt        # Dependências
├── README.md              # Documentação
├── scripts/
│   └── setup.sh           # Setup automático
└── venv/                  # Ambiente virtual
```

## 🎮 Ambientes Suportados

- **CartPole** (teste/prototipagem)
- **Minecraft** (objetivo principal)
- **Atari** (games clássicos)

## 🤖 Algoritmos RL

- PPO (Proximal Policy Optimization) - Recomendado
- DQN (Deep Q-Network)
- A2C (Advantage Actor-Critic)

## 📚 Referências

- [MineRL Documentation](https://minerl.io/)
- [Gymnasium](https://gymnasium.farama.org/)
- [Stable-Baselines3](https://stable-baselines3.readthedocs.io/)

## 📝 Licença

MIT
