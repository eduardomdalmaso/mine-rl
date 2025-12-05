# Mine-RL: Agentes Inteligentes no Minecraft

Ambiente Python para treinar agentes de **Reinforcement Learning** em ambientes simulados tipo Minecraft. Este projeto fornece um setup completo com Gymnasium para desenvolver e testar agentes inteligentes.

## ⚠️ Nota Importante

**MineRL (versão oficial) é incompatível com Python 3.12.** Este projeto usa **Gymnasium** como alternativa principal, que é:
- ✓ Compatível com Python 3.12
- ✓ Bem mantido e atualizado
- ✓ Perfeito para treinar agentes RL
- ✓ Suporta muitos ambientes

Se precisar de Minecraft real, use opções como:
- Minecraft Forge + API customizada
- Mineflayer (Node.js based)
- Ou versione seu Python para 3.11

## 🎮 Visualização em Tempo Real

Com seu **Ryzen 7 7800X3D** você pode ver o agente aprendendo em tempo real! O projeto inclui:

- 👀 **Visualização ao vivo** do agente treinando
- 🎥 **Gravação de gameplay** em vídeo MP4
- 🎯 **Treinamento interativo** com renderização
- 📊 **Estatísticas em tempo real** (FPS, recompensas, etc)

## 🎯 Objetivo

Treinar agentes RL que aprendam a:
- Navegar em ambientes 3D
- Resolver problemas e desafios
- Otimizar estratégias
- Maximizar recompensas

## 🚀 Quick Start

### 1. Instalação Básica

```bash
# Clone o repositório
git clone https://github.com/eduardomdalmaso/mine-rl.git
cd mine-rl

# Setup automático
bash scripts/complete_setup.sh
```

### 2. Teste Rápido

```bash
python test_env.py
```

### 3. Visualização

```bash
bash scripts/run.sh
```

### 4. Minecraft (Opcional)

Para usar Minecraft real, veja `scripts/minecraft_setup.sh`

## 📦 Dependências

- **gymnasium**: Ambientes RL padronizados ✓
- **stable-baselines3**: Algoritmos RL (PPO, DQN, A2C) ✓
- **torch**: Deep Learning com PyTorch ✓
- **numpy**: Computação numérica ✓
- **opencv-python**: Processamento de imagens + gravação de vídeo ✓

## 📁 Estrutura

```
mine-rl/
├── agent_minecraft.py       # Agente principal (estrutura)
├── visual_agent.py          # Agente com visualização
├── minecraft_viewer.py      # Info sobre Minecraft
├── test_env.py              # Script de teste
├── requirements.txt         # Dependências
├── README.md               # Esta documentação
├── scripts/
│   ├── complete_setup.sh   # Setup completo
│   ├── minecraft_setup.sh  # Info Minecraft
│   ├── run.sh              # Menu interativo
│   └── README.md           # Guia dos scripts
└── venv/                   # Ambiente virtual
```

## 🎮 Ambientes Disponíveis

### Recomendados (Gymnasium)
- **CartPole-v1** - Balancear poste (clássico)
- **MountainCar-v0** - Subir montanha com carro
- **LunarLander-v2** - Pousar módulo lunar ⭐
- **Acrobot-v1** - Controlar pêndulo duplo
- **BipedalWalker-v3** - Fazer bípede caminhar

### Mais Complexos
- **Atari** (com ale-py)
- **Robótica** (com mujoco)

## 🤖 Algoritmos Suportados

- **PPO** (Proximal Policy Optimization) - ⭐ Recomendado
- **DQN** (Deep Q-Network)
- **A2C** (Advantage Actor-Critic)
- **DDPG** (Deep Deterministic Policy Gradient)
- **SAC** (Soft Actor-Critic)
- **TD3** (Twin Delayed DDPG)

## 📺 Exemplo de Uso - Visualização

```python
from visual_agent import VisualMinecraftAgent

# Criar agente visual
agent = VisualMinecraftAgent(env_name="LunarLander-v2", render=True)
agent.create_environment(render_mode="human")
agent.create_model()

# Ver agente em tempo real
agent.render_episode(num_steps=500)

# Ou gravar como vídeo
agent.render_rgb_array(num_steps=500, output_video="gameplay.mp4")
```

## ✅ Checklist de Setup

```
✓ Python 3.12 instalado
✓ Git instalado
✓ ~5GB espaço livre
```

Execute para verificar:
```bash
bash scripts/complete_setup.sh
```

## 🖥️ Requisitos de Hardware

| Recurso | Mínimo | Recomendado | Seu Setup |
|---------|--------|-------------|-----------|
| CPU | i5-8400 | Ryzen 5 5600X | Ryzen 7 7800X3D ✓ |
| RAM | 8GB | 16GB | 64GB ✓ |
| GPU | GTX 1060 | RTX 2080 | Integrada é suficiente |
| Espaço | 10GB | 30GB | - |

**Com seu setup você tem performance EXCELENTE!**

## 📚 Referências

- [Gymnasium Documentation](https://gymnasium.farama.org/)
- [Stable-Baselines3](https://stable-baselines3.readthedocs.io/)
- [OpenAI Spinning Up](https://spinningup.openai.com/)

## 🆘 Problemas?

**Erro com MineRL?**
- É normal, MineRL não suporta Python 3.12
- Use Gymnasium (já está pronto!)

**Quer Minecraft real?**
- Veja `scripts/minecraft_setup.sh` para opções

## 📝 Licença

MIT
