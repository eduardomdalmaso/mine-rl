"""
Script de teste básico para RL environment
Verifica se as dependências estão instaladas corretamente
"""

import gymnasium
from stable_baselines3 import PPO
import numpy as np

def test_environment():
    """Testa o ambiente básico do Gymnasium"""
    try:
        # Criar ambiente de teste (CartPole é simples e serve para validar)
        env = gymnasium.make('CartPole-v1')
        print("✓ Ambiente Gymnasium criado com sucesso!")
        
        # Obter informações
        print(f"Espaço de ação: {env.action_space}")
        print(f"Espaço de observação: {env.observation_space}")
        
        # Reset e teste básico
        obs, info = env.reset()
        print(f"✓ Observação inicial obtida: shape={obs.shape}")
        
        # Testar um passo
        action = env.action_space.sample()
        obs, reward, terminated, truncated, info = env.step(action)
        print(f"✓ Step executado: reward={reward}")
        
        env.close()
        print("✓ Teste concluído com sucesso!")
        
        # Testar importação do Torch
        import torch
        print(f"✓ PyTorch versão: {torch.__version__}")
        
        # Testar Stable-Baselines3
        print(f"✓ Stable-Baselines3 importado com sucesso!")
        
        return True
        
    except Exception as e:
        print(f"✗ Erro: {e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == "__main__":
    test_environment()
