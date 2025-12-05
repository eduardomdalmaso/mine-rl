# Mine-RL: Agentes Inteligentes no Minecraft

Ambiente Python para treinar agentes de **Reinforcement Learning** no Minecraft usando MineRL. Este projeto fornece um setup completo para desenvolver e testar agentes inteligentes capazes de realizar tarefas complexas no jogo.

## 🎮 Visualização em Tempo Real

Com seu **Ryzen 7 7800X3D** você pode ver o agente jogando Minecraft **em tempo real**! O projeto inclui:

- 👀 **Visualização ao vivo** do agente jogando
- 🎥 **Gravação de gameplay** em vídeo MP4
- 🎯 **Treinamento interativo** com renderização
- 📊 **Estatísticas em tempo real** (FPS, recompensas, etc)

## 🎯 Objetivo

Treinar agentes RL que aprendam a:
- Navegar em ambientes 3D
- Coletar recursos
- Executar tarefas sequenciais
- Interagir com o ambiente do Minecraft

## 🚀 Quick Start

### 1. Instalação Básica

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

### 2. Teste Rápido (sem Minecraft)

```bash
python test_env.py
```

### 3. Visualização (CartPole - teste)

```bash
python visual_agent.py
```

### 4. Setup para Minecraft Real

```bash
# 1. Instale Minecraft Java Edition Original
# Baixe em: https://launcher.mojang.com/

# 2. Instale MineRL
pip install minerl

# 3. Verifique o setup
python minecraft_viewer.py

# 4. Rode o agente visual
python visual_agent.py
```

## 📦 Dependências

- **gymnasium**: Ambientes RL padronizados
- **stable-baselines3**: Algoritmos RL (PPO, DQN, A2C)
- **torch**: Deep Learning com PyTorch
- **numpy**: Computação numérica
- **opencv-python**: Processamento de imagens + gravação de vídeo
- **minerl**: Ambiente Minecraft para RL

## 📁 Estrutura

```
mine-rl/
├── agent_minecraft.py       # Agente principal (estrutura)
├── visual_agent.py          # Agente com visualização
├── minecraft_viewer.py      # Setup e checker do Minecraft
├── test_env.py              # Script de teste
├── requirements.txt         # Dependências
├── README.md               # Esta documentação
├── scripts/
│   └── setup.sh            # Setup automático
└── venv/                   # Ambiente virtual
```

## 🎮 Ambientes Disponíveis

### Desenvolvimento
- **CartPole** - Teste básico
- **MountainCar** - Escalada simples

### Minecraft (com MineRL)
- **Navigate** - Navegar em mundo aberto
- **ObtainBlock** - Coletar blocos específicos
- **Obtain Diamond** - Desafio de conseguir diamante

## 🤖 Algoritmos Suportados

- PPO (Proximal Policy Optimization) - ⭐ Recomendado
- DQN (Deep Q-Network)
- A2C (Advantage Actor-Critic)

## 📺 Exemplo de Uso - Visualização

```python
from visual_agent import VisualMinecraftAgent

# Criar agente visual
agent = VisualMinecraftAgent(env_name="CartPole-v1", render=True)
agent.create_environment(render_mode="human")
agent.create_model()

# Ver agente em tempo real
agent.render_episode(num_steps=500)

# Ou gravar como vídeo
agent.render_rgb_array(num_steps=500, output_video="gameplay.mp4")
```

## ✅ Checklist de Setup - Minecraft Real

```
✓ Java JDK instalado
✓ Minecraft Java Edition (original)
✓ Conta Minecraft ativa
✓ MineRL instalado (pip install minerl)
✓ ~10GB espaço livre (para Minecraft 1.12.2)
```

Execute para verificar:
```bash
python minecraft_viewer.py
```

## 🖥️ Requisitos de Hardware

| Recurso | Mínimo | Recomendado | Seu Setup |
|---------|--------|-------------|-----------|
| CPU | i5-8400 | Ryzen 5 5600X | Ryzen 7 7800X3D ✓ |
| RAM | 8GB | 16GB | 64GB ✓ |
| GPU | GTX 1060 | RTX 2080 | Integrada é suficiente |
| Espaço | 20GB | 50GB | - |

**Com seu setup você tem performance excelente para visualizar e treinar agentes!**

## 📚 Referências

- [MineRL Documentation](https://minerl.io/)
- [Gymnasium](https://gymnasium.farama.org/)
- [Stable-Baselines3](https://stable-baselines3.readthedocs.io/)

## 📝 Licença

MIT
