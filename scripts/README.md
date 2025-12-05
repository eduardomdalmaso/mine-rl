# Scripts de Automação - Mine-RL

Pasta com scripts `.sh` para automatizar todo o setup e execução do projeto.

## 📋 Scripts Disponíveis

### 1. `complete_setup.sh` - Setup Completo ⭐
**Use este primeiro!**

```bash
bash scripts/complete_setup.sh
```

Faz:
- ✓ Verifica Python 3.12
- ✓ Cria ambiente virtual
- ✓ Instala todas as dependências
- ✓ Pergunta se quer instalar MineRL

### 2. `minecraft_setup.sh` - Setup do Minecraft
**Execute após `complete_setup.sh`**

```bash
bash scripts/minecraft_setup.sh
```

Faz:
- ✓ Verifica dependências
- ✓ Instala MineRL
- ✓ Prepara Minecraft 1.12.2
- ✓ Testa a instalação

### 3. `run.sh` - Menu Interativo ⚡
**Use para executar tudo rapidamente!**

```bash
bash scripts/run.sh
```

Menu com opções:
1. Testar ambiente (CartPole)
2. Ver agente em tempo real
3. Gravar gameplay em vídeo
4. Verificar setup Minecraft
5. Treinar agente
6. Sair

## 🚀 Guia Rápido

**Primeira vez:**
```bash
bash scripts/complete_setup.sh
bash scripts/minecraft_setup.sh
```

**Usar depois:**
```bash
bash scripts/run.sh
```

## ✅ Checklist

- [ ] Executou `complete_setup.sh`
- [ ] Executou `minecraft_setup.sh` (se quer Minecraft)
- [ ] Testou com `bash scripts/run.sh`
- [ ] Viu o agente em ação 🎮

## 🎯 Fluxo Recomendado

1. **Primeiro dia:**
   ```bash
   bash scripts/complete_setup.sh
   ```

2. **Para usar Minecraft:**
   ```bash
   bash scripts/minecraft_setup.sh
   ```

3. **Depois disso, sempre use:**
   ```bash
   bash scripts/run.sh
   ```

## 📝 Notas

- Scripts requerem permissão de execução (já configurado)
- Testado em Linux e macOS
- Windows: Use Git Bash ou WSL
- Primeira execução do MineRL baixa ~2GB

## 🆘 Problemas?

Se um script não funcionar:

```bash
# Dar permissão manualmente
chmod +x scripts/*.sh

# Ou executar com bash
bash scripts/complete_setup.sh
```

---

**Enjoy! 🎮🤖**
