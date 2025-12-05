"""
Exemplo básico de agente com Stable Baselines3
Treina um agente com PPO em CartPole (pode expandir para ambientes mais complexos)
"""

import gymnasium
from stable_baselines3 import PPO
import numpy as np

def create_agent():
    """Cria e configura um agente PPO básico"""
    
    # Criar ambiente
    env = gymnasium.make('CartPole-v1')
    
    # Criar agente PPO
    model = PPO(
        'MlpPolicy',
        env,
        verbose=1,
        learning_rate=3e-4,
        n_steps=2048,
        batch_size=64
    )
    
    print("✓ Agente PPO criado! Pronto para treinamento.")
    return model, env

def train_agent(model, env, timesteps=10000):
    """Entrena o agente"""
    print(f"Iniciando treinamento por {timesteps} steps...")
    model.learn(total_timesteps=timesteps)
    print("✓ Treinamento concluído!")
    
def test_agent(model, env, episodes=3):
    """Testa o agente treinado"""
    print(f"Testando agente por {episodes} episódios...")
    
    for ep in range(episodes):
        obs, info = env.reset()
        done = False
        reward_sum = 0
        
        while not done:
            action, _ = model.predict(obs, deterministic=True)
            obs, reward, terminated, truncated, info = env.step(action)
            done = terminated or truncated
            reward_sum += reward
        
        print(f"Episódio {ep+1}: Recompensa total = {reward_sum:.1f}")

if __name__ == "__main__":
    model, env = create_agent()
    # Descomente as linhas abaixo para treinar:
    # train_agent(model, env, timesteps=50000)
    # test_agent(model, env, episodes=5)
    # model.save("ppo_cartpole")
    env.close()
