"""
Agent Minecraft - Agente de Reinforcement Learning para Minecraft
Projeto Mine-RL: Treinamento de agentes inteligentes no Minecraft

Este é um esboço do projeto que será expandido para suportar
treinamento de agentes no ambiente Minecraft usando MineRL.
"""

import gymnasium
import numpy as np
from stable_baselines3 import PPO
from stable_baselines3.common.env_util import make_vec_env
import logging

# Configurar logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class MinecraftAgent:
    """
    Classe principal para gerenciar agentes de RL no Minecraft
    """
    
    def __init__(self, env_name="CartPole-v1", model_name="ppo_minecraft"):
        """
        Inicializa o agente
        
        Args:
            env_name: Nome do ambiente Gymnasium
            model_name: Nome para salvar/carregar o modelo
        """
        self.env_name = env_name
        self.model_name = model_name
        self.env = None
        self.model = None
        
        logger.info(f"Agente inicializado para {env_name}")
    
    def create_environment(self, num_envs=1):
        """
        Cria o ambiente de treinamento
        
        Args:
            num_envs: Número de ambientes paralelos
        """
        if num_envs > 1:
            self.env = make_vec_env(self.env_name, n_envs=num_envs)
        else:
            self.env = gymnasium.make(self.env_name)
        
        logger.info(f"Ambiente criado: {self.env_name}")
        return self.env
    
    def create_model(self, policy="MlpPolicy", learning_rate=3e-4, **kwargs):
        """
        Cria o modelo PPO
        
        Args:
            policy: Tipo de política (MlpPolicy, CnnPolicy)
            learning_rate: Taxa de aprendizado
            **kwargs: Argumentos adicionais para o PPO
        """
        if self.env is None:
            self.create_environment()
        
        self.model = PPO(
            policy,
            self.env,
            learning_rate=learning_rate,
            verbose=1,
            **kwargs
        )
        
        logger.info("Modelo PPO criado com sucesso")
        return self.model
    
    def train(self, total_timesteps=100000):
        """
        Treina o agente
        
        Args:
            total_timesteps: Número total de steps para treinar
        """
        if self.model is None:
            self.create_model()
        
        logger.info(f"Iniciando treinamento por {total_timesteps} steps...")
        self.model.learn(total_timesteps=total_timesteps)
        logger.info("Treinamento concluído!")
    
    def test(self, num_episodes=5, render=False):
        """
        Testa o agente treinado
        
        Args:
            num_episodes: Número de episódios para testar
            render: Se deve renderizar o ambiente
        """
        if self.model is None:
            logger.error("Modelo não foi criado/treinado!")
            return
        
        env = gymnasium.make(self.env_name, render_mode="human" if render else None)
        
        total_rewards = []
        
        for episode in range(num_episodes):
            obs, info = env.reset()
            done = False
            episode_reward = 0
            
            while not done:
                action, _ = self.model.predict(obs, deterministic=True)
                obs, reward, terminated, truncated, info = env.step(action)
                done = terminated or truncated
                episode_reward += reward
            
            total_rewards.append(episode_reward)
            logger.info(f"Episódio {episode + 1}: Recompensa = {episode_reward:.2f}")
        
        env.close()
        
        avg_reward = np.mean(total_rewards)
        logger.info(f"Recompensa média: {avg_reward:.2f}")
        
        return total_rewards
    
    def save_model(self):
        """Salva o modelo treinado"""
        if self.model is None:
            logger.error("Nenhum modelo para salvar!")
            return
        
        self.model.save(self.model_name)
        logger.info(f"Modelo salvo como {self.model_name}")
    
    def load_model(self):
        """Carrega um modelo previamente treinado"""
        self.model = PPO.load(self.model_name)
        logger.info(f"Modelo carregado de {self.model_name}")
        return self.model
    
    def close(self):
        """Fecha o ambiente"""
        if self.env is not None:
            self.env.close()
            logger.info("Ambiente fechado")


def main():
    """
    Script principal de demonstração
    """
    # Criar agente
    agent = MinecraftAgent(env_name="CartPole-v1", model_name="ppo_cartpole_demo")
    
    # Criar ambiente e modelo
    agent.create_environment()
    agent.create_model(
        learning_rate=3e-4,
        n_steps=2048,
        batch_size=64,
        n_epochs=10
    )
    
    # Treinar (descomente para treinar)
    # agent.train(total_timesteps=50000)
    # agent.save_model()
    
    # Testar
    logger.info("Testando agente em modo de demonstração...")
    agent.test(num_episodes=3)
    
    # Fechar ambiente
    agent.close()


if __name__ == "__main__":
    main()
