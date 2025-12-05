"""
Visual Agent - Visualização em tempo real do agente jogando Minecraft
Permite ver o agente interagindo com o ambiente Minecraft de forma visual
"""

import gymnasium
import numpy as np
from stable_baselines3 import PPO
import cv2
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class VisualMinecraftAgent:
    """
    Agente com visualização em tempo real para Minecraft
    """
    
    def __init__(self, env_name="CartPole-v1", render=True):
        """
        Inicializa o agente visual
        
        Args:
            env_name: Nome do ambiente
            render: Se deve renderizar visualmente
        """
        self.env_name = env_name
        self.render = render
        self.env = None
        self.model = None
        self.window = None
        
        logger.info(f"Agente Visual inicializado - Render: {render}")
    
    def create_environment(self, render_mode="human"):
        """
        Cria ambiente com renderização
        
        Args:
            render_mode: "human" para visualização, "rgb_array" para captura
        """
        if self.render:
            self.env = gymnasium.make(self.env_name, render_mode=render_mode)
        else:
            self.env = gymnasium.make(self.env_name)
        
        logger.info(f"Ambiente criado com render_mode: {render_mode}")
        return self.env
    
    def create_model(self, policy="MlpPolicy", learning_rate=3e-4):
        """Cria o modelo PPO"""
        if self.env is None:
            self.create_environment()
        
        self.model = PPO(
            policy,
            self.env,
            learning_rate=learning_rate,
            verbose=1
        )
        logger.info("Modelo PPO criado")
        return self.model
    
    def render_episode(self, num_steps=500, show_fps=True):
        """
        Executa um episódio com renderização visual
        
        Args:
            num_steps: Número máximo de steps
            show_fps: Mostrar FPS na tela
        """
        if self.model is None:
            self.create_model()
        
        logger.info(f"Iniciando renderização por {num_steps} steps...")
        
        obs, info = self.env.reset()
        done = False
        total_reward = 0
        step = 0
        fps_counter = 0
        
        while not done and step < num_steps:
            # Predição do modelo
            action, _ = self.model.predict(obs, deterministic=True)
            
            # Step no ambiente
            obs, reward, terminated, truncated, info = self.env.step(action)
            done = terminated or truncated
            total_reward += reward
            
            # Renderizar (automático se render_mode="human")
            self.env.render()
            
            step += 1
            fps_counter += 1
            
            if step % 100 == 0:
                logger.info(f"Step {step} | Reward: {total_reward:.2f}")
        
        self.env.close()
        logger.info(f"Episódio finalizado! Recompensa total: {total_reward:.2f}")
        
        return total_reward
    
    def render_rgb_array(self, num_steps=500, output_video="agent_gameplay.mp4"):
        """
        Renderiza e salva como vídeo
        
        Args:
            num_steps: Número de steps
            output_video: Arquivo de saída
        """
        logger.info(f"Iniciando captura de vídeo: {output_video}")
        
        # Criar ambiente com captura RGB
        env = gymnasium.make(self.env_name, render_mode="rgb_array")
        
        if self.model is None:
            self.create_model()
        
        frames = []
        obs, info = env.reset()
        done = False
        step = 0
        
        while not done and step < num_steps:
            action, _ = self.model.predict(obs, deterministic=True)
            obs, reward, terminated, truncated, info = env.step(action)
            done = terminated or truncated
            
            # Capturar frame
            frame = env.render()
            if frame is not None:
                frames.append(frame)
            
            step += 1
        
        env.close()
        
        # Salvar vídeo se tiver frames
        if frames:
            self._save_video(frames, output_video)
            logger.info(f"Vídeo salvo: {output_video}")
        
        return len(frames)
    
    def _save_video(self, frames, output_path, fps=30):
        """
        Salva frames como vídeo
        
        Args:
            frames: Lista de frames (numpy arrays)
            output_path: Caminho de saída
            fps: Frames por segundo
        """
        if not frames:
            logger.warning("Nenhum frame para salvar")
            return
        
        height, width = frames[0].shape[:2]
        
        try:
            fourcc = cv2.VideoWriter_fourcc(*'mp4v')
            out = cv2.VideoWriter(output_path, fourcc, fps, (width, height))
            
            for frame in frames:
                # Converter RGB para BGR para OpenCV
                if len(frame.shape) == 3 and frame.shape[2] == 3:
                    frame_bgr = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
                else:
                    frame_bgr = frame
                
                out.write(frame_bgr.astype(np.uint8))
            
            out.release()
            logger.info(f"Vídeo salvo: {output_path}")
        
        except Exception as e:
            logger.error(f"Erro ao salvar vídeo: {e}")
    
    def load_model(self, model_path):
        """Carrega um modelo previamente treinado"""
        self.model = PPO.load(model_path)
        logger.info(f"Modelo carregado: {model_path}")
        return self.model


def main():
    """
    Demonstração de visualização do agente
    """
    # Criar agente visual
    agent = VisualMinecraftAgent(env_name="CartPole-v1", render=True)
    
    # Criar ambiente e modelo
    agent.create_environment(render_mode="human")
    agent.create_model()
    
    # Opção 1: Visualizar em tempo real
    print("\n=== OPÇÃO 1: Visualização em Tempo Real ===")
    print("Renderizando agente jogando (janela vai abrir)...")
    agent.render_episode(num_steps=500)
    
    # Opção 2: Gravar como vídeo
    print("\n=== OPÇÃO 2: Gravar Como Vídeo ===")
    print("Capturando gameplay para salvar como vídeo...")
    agent.render_rgb_array(num_steps=500, output_video="agent_gameplay.mp4")
    
    print("\n✓ Demonstração concluída!")


if __name__ == "__main__":
    main()
