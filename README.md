# Mine-RL: Agentes RL no Minecraft

Treine agentes de **Reinforcement Learning** para jogar **Minecraft** usando MineRL + Stable-Baselines3. Visualize seus agentes jogando em tempo real com renderização.

## 🎮 Características

- 👀 Visualização ao vivo do agente jogando Minecraft
- 🎥 Gravação de gameplay em vídeo MP4
- 🤖 Algoritmos RL: PPO, DQN, A2C, SAC, TD3
- 📊 Treinamento configurável com logging

## 🎯 Objetivo

Treinar agentes RL que aprendam a:
- Navegar em ambientes 3D (Minecraft)
- Coletar recursos e materiais
- Executar tarefas sequenciais
- Resolver desafios e objetivos

## 🚀 Quick Start

```bash
# Clone
git clone https://github.com/eduardomdalmaso/mine-rl.git
cd mine-rl

# Setup Python + dependências
bash scripts/complete_setup.sh

# Instalar MineRL (requer Java 8+)
bash scripts/minecraft_setup.sh

# Menu interativo
bash scripts/run.sh
```

## 📦 Dependências

- **gymnasium**: Ambientes RL padronizados ✓
- **stable-baselines3**: Algoritmos RL (PPO, DQN, A2C) ✓
- **torch**: Deep Learning com PyTorch ✓
- **numpy**: Computação numérica ✓
- **opencv-python**: Processamento de imagens ✓
- **minerl**: Ambiente Minecraft para RL (instalado via GitHub)

## 📁 Estrutura

```
mine-rl/
├── agent_minecraft.py      # Agente RL principal
├── visual_agent.py         # Renderização + vídeo
├── minecraft_viewer.py     # Verificação de requisitos
├── requirements.txt        # Dependências
├── README.md               # Esta documentação
└── scripts/
    ├── complete_setup.sh   # Setup automático
    ├── minecraft_setup.sh  # Instala MineRL
    └── run.sh              # Menu interativo
```

## 🎮 Ambientes MineRL Disponíveis

- **Navigate-v0** - Navegar no mundo
- **ObtainDiamond-v0** - Conseguir diamante ⭐
- **MineRLBasaltFindCave-v0** - Encontrar caverna
- **MineRLBasaltCreateVillageAnimalPen-v0** - Criar cercado
- **MineRLBasaltBuildVillageHouse-v0** - Construir casa
- **MineRLBasaltMakeWaterfall-v0** - Fazer cascata

Veja mais em [MineRL Docs](https://minerl.readthedocs.io/)

## 🤖 Algoritmos Suportados

- **PPO** (Proximal Policy Optimization) - ⭐ Recomendado
- **DQN** (Deep Q-Network)
- **A2C** (Advantage Actor-Critic)
- **DDPG** (Deep Deterministic Policy Gradient)
- **SAC** (Soft Actor-Critic)
- **TD3** (Twin Delayed DDPG)

## 📺 Exemplo de Uso

```python
from visual_agent import VisualMinecraftAgent

# Com Gymnasium
agent = VisualMinecraftAgent(env_name="LunarLander-v2", render=True)
agent.create_environment(render_mode="human")
agent.create_model()
agent.render_episode(num_steps=500)

# Com MineRL (após setup)
agent = VisualMinecraftAgent(env_name="MineRLObtainDiamond-v0", render=True)
agent.create_environment(render_mode="human")
agent.create_model()
agent.render_episode(num_steps=500)
```

## ✅ Setup Mínimo Recomendado

### 🖥️ Requisitos Mínimos
| Recurso | Mínimo | Recomendado |
|---------|--------|------------|
| **CPU** | Intel i5 / Ryzen 5 (4 núcleos) | Intel i7 / Ryzen 7 (6+ núcleos) |
| **RAM** | 8GB | 16GB+ |
| **GPU** | CPU integrada ou GTX 1050 | RTX 2060+ / RTX 3060+ |
| **Espaço** | 5GB | 15GB |
| **Python** | 3.8+ | 3.10+ |
| **Java** | OpenJDK 8+ | OpenJDK 8+ |

### Especificações por Algoritmo
| Algoritmo | CPU | RAM | GPU | Tempo/Época |
|-----------|-----|-----|-----|------------|
| **PPO** | 4 cores | 8GB | CPU | ~2-5 min |
| **DQN** | 4 cores | 6GB | CPU | ~1-3 min |
| **A2C** | 2 cores | 4GB | CPU | ~30 seg |

### 💾 Espaço em Disco
- **Codebase**: ~200MB
- **Python + dependências**: ~2GB
- **MineRL assets**: ~2.5GB
- **Modelos salvos**: ~500MB-1GB por modelo
- **Vídeos**: ~100-500MB por episódio gravado
- **Total recomendado**: 15GB livre

## 🆘 Problemas?

**Java não encontrado?**
```bash
# Fedora/RHEL
sudo dnf install java-1.8.0-openjdk

# Ubuntu/Debian
sudo apt-get install openjdk-8-jdk

# macOS
brew install openjdk@8
```

**MineRL não instala?**
```bash
bash scripts/minecraft_setup.sh
```

Veja [MineRL Installation](https://minerl.readthedocs.io/en/latest/tutorials/getting_started.html) para mais ajuda.

## 📝 Licença

MIT
