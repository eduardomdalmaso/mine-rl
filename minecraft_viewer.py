"""
Minecraft Viewer - Integração com Minecraft original para visualização
Requer Minecraft Java Edition instalado e MineRL configurado
"""

import subprocess
import logging
import json
import os
from pathlib import Path

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class MinecraftViewer:
    """
    Gerenciador para visualização do agente em Minecraft real
    """
    
    def __init__(self, java_path=None, minecraft_dir=None):
        """
        Inicializa o viewer
        
        Args:
            java_path: Caminho para Java executable
            minecraft_dir: Diretório do Minecraft
        """
        self.java_path = java_path or self._find_java()
        self.minecraft_dir = minecraft_dir or self._find_minecraft_dir()
        
        logger.info(f"Java: {self.java_path}")
        logger.info(f"Minecraft Dir: {self.minecraft_dir}")
    
    def _find_java(self):
        """Localiza Java instalado"""
        import shutil
        java = shutil.which("java")
        if not java:
            raise RuntimeError("Java não encontrado. Instale Java JDK")
        return java
    
    def _find_minecraft_dir(self):
        """Localiza diretório do Minecraft"""
        home = Path.home()
        
        # Linux
        if (home / ".minecraft").exists():
            return str(home / ".minecraft")
        
        # Windows
        appdata = os.getenv("APPDATA")
        if appdata and (Path(appdata) / ".minecraft").exists():
            return str(Path(appdata) / ".minecraft")
        
        raise RuntimeError(
            "Diretório do Minecraft não encontrado. "
            "Instale Minecraft Java Edition"
        )
    
    def install_minerl(self):
        """Instala MineRL e dependências"""
        logger.info("Instalando MineRL...")
        
        # Será feito via pip install minerl
        logger.info("Execute: pip install minerl")
    
    def check_requirements(self):
        """Verifica se tudo está pronto"""
        checks = {
            "Java": self._check_java(),
            "Minecraft": self._check_minecraft(),
            "MineRL": self._check_minerl(),
        }
        
        logger.info("=== Checklist ===")
        for name, status in checks.items():
            symbol = "✓" if status else "✗"
            logger.info(f"{symbol} {name}")
        
        return all(checks.values())
    
    def _check_java(self):
        """Verifica Java"""
        try:
            result = subprocess.run(
                [self.java_path, "-version"],
                capture_output=True,
                timeout=5
            )
            return result.returncode == 0
        except:
            return False
    
    def _check_minecraft(self):
        """Verifica Minecraft"""
        return Path(self.minecraft_dir).exists()
    
    def _check_minerl(self):
        """Verifica MineRL"""
        try:
            import minerl
            return True
        except:
            return False
    
    def get_setup_instructions(self):
        """Retorna instruções de setup"""
        instructions = """
        === SETUP PARA VISUALIZAÇÃO EM MINECRAFT ===
        
        1. Instale Minecraft Java Edition Original
           - Baixe em: https://launcher.mojang.com/
           - Execute e faça login com sua conta
        
        2. Instale MineRL (em seu venv):
           source venv/bin/activate
           pip install minerl
        
        3. Configure o Launcherwrapper:
           - MineRL vai fazer isso automaticamente
           - Pode levar alguns minutos na primeira vez
        
        4. Execute o agente visual:
           python visual_agent.py
        
        === OBSERVAÇÕES ===
        - Seu Ryzen 7 7800X3D é perfeito para isso
        - Recomendado: 60+ FPS em 1080p com ray tracing desativado
        - Pode gravar gameplay como vídeo MP4
        - MineRL usa Minecraft 1.12.2
        """
        return instructions


def setup_minerl_python():
    """Script para fazer setup automático"""
    print("""
    === SETUP AUTOMÁTICO DO MINERL ===
    
    Pré-requisitos:
    1. Minecraft Java Edition ORIGINAL instalado
    2. Conta Minecraft ativa
    3. Python 3.12 (já tem)
    4. 10GB+ de espaço livre
    
    Execute os comandos abaixo:
    
    # 1. Ativar venv
    source venv/bin/activate
    
    # 2. Instalar MineRL
    pip install minerl
    
    # 3. Baixar Minecraft 1.12.2 (automático)
    python -c "import minerl; print('MineRL pronto!')"
    
    # 4. Rodar agente visual
    python visual_agent.py
    
    """)


if __name__ == "__main__":
    viewer = MinecraftViewer()
    
    print(viewer.get_setup_instructions())
    
    print("\nVerificando requisitos...")
    if viewer.check_requirements():
        print("✓ Tudo pronto para começar!")
    else:
        print("✗ Faltam alguns requisitos")
