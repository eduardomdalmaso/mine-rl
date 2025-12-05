# MineRL Agent Training

Um ambiente Python para treinar agentes de **Reinforcement Learning (RL)** em ambientes complexos, começando com Gymnasium e expandindo para Minecraft.

## 🎯 Objetivo

Este projeto fornece um setup pronto para praticar e desenvolver algoritmos de RL, evoluindo de problemas simples (CartPole) para ambientes mais desafiadores como Minecraft. Ideal para quem quer aprender RL de forma progressiva.

## 🚀 Começando

### Pré-requisitos
- Python 3.12+
- pip

### Instalação Rápida

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/minerl-rl-agent.git
cd minerl-rl-agent

# Execute o setup automático
bash scripts/setup.sh

# Ou configure manualmente
python3.12 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### Primeiro Teste

```bash
source venv/bin/activate
python test_env.py
```

## 📦 Dependências

- **gymnasium**: Ambientes RL padronizados
- **stable-baselines3**: Algoritmos RL prontos (PPO, DQN, A2C, etc)
- **torch**: Deep Learning framework
- **numpy**: Computação numérica
- **opencv-python**: Processamento de imagens

## 📚 Estrutura do Projeto

```
.
├── agent_basic.py          # Exemplo básico de agente PPO
├── test_env.py             # Script de teste do ambiente
├── requirements.txt        # Dependências Python
├── README.md              # Documentação detalhada
├── scripts/
│   └── setup.sh           # Script de configuração automática
└── venv/                  # Ambiente virtual Python
```

## 💡 Exemplos de Uso

### Teste o ambiente
```bash
python test_env.py
```

### Treine um agente
```python
from agent_basic import create_agent, train_agent, test_agent

model, env = create_agent()
train_agent(model, env, timesteps=50000)
test_agent(model, env, episodes=5)
model.save("ppo_cartpole")
env.close()
```

### Use um modelo treinado
```python
from stable_baselines3 import PPO
import gymnasium

env = gymnasium.make('CartPole-v1')
model = PPO.load("ppo_cartpole")

obs, _ = env.reset()
done = False
while not done:
    action, _ = model.predict(obs, deterministic=True)
    obs, reward, terminated, truncated, _ = env.step(action)
    done = terminated or truncated
    env.render()
env.close()
```

## 🎮 Ambientes Disponíveis

### Nível 1: Simples
- `CartPole-v1` - Balancear um poste em um carrinho
- `MountainCar-v0` - Subir uma montanha com um carro

### Nível 2: Intermediário
- `Pendulum-v1` - Controlar um pêndulo
- `LunarLander-v2` - Pousar um módulo lunar
- `BipedalWalker-v3` - Fazer um bípede caminhar

### Nível 3: Avançado
- `Minecraft` (com MineRL) - Ambientes 3D complexos
- `Atari` (com ALE) - Jogos clássicos

## 🤖 Algoritmos Suportados

- **PPO** (Proximal Policy Optimization) - Recomendado para iniciantes
- **DQN** (Deep Q-Network)
- **A2C** (Advantage Actor-Critic)
- **DDPG** (Deep Deterministic Policy Gradient)
- **SAC** (Soft Actor-Critic)
- **TD3** (Twin Delayed DDPG)

## 📈 Roadmap

- [x] Setup básico com Gymnasium
- [x] Exemplos com PPO
- [x] Script de teste
- [ ] Suporte a Minecraft (MineRL)
- [ ] Treinamento com múltiplos ambientes
- [ ] Visualização de treinamento com TensorBoard
- [ ] Exemplos com transfer learning
- [ ] Documentação expandida

## 🔗 Recursos Úteis

- [Gymnasium Documentation](https://gymnasium.farama.org/)
- [Stable-Baselines3](https://stable-baselines3.readthedocs.io/)
- [MineRL](https://minerl.io/)
- [OpenAI Spinning Up](https://spinningup.openai.com/)

## 📝 Licença

MIT License - veja LICENSE.md para mais detalhes

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se livre para abrir issues e pull requests.

## ✍️ Autor

[Seu Nome]

## 📧 Contato

Para dúvidas ou sugestões, abra uma issue no repositório.

---

**⭐ Se este projeto foi útil, considere dar uma estrela!**
