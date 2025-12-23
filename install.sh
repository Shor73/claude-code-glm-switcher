#!/bin/bash

# Claude Code - GLM Switcher Installer
# Installa gli script per usare Claude Code con modelli GLM o Claude nativi

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Claude Code - GLM Switcher Installer    ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════╝${NC}"
echo
echo -e "${CYAN}Nuova versione: Comandi separati per ogni modello!${NC}"
echo

# Check prerequisites
echo -e "${YELLOW}Controllo prerequisiti...${NC}"

# Check Claude Code
if command -v claude &> /dev/null; then
    echo -e "${GREEN}✓ Claude Code installato${NC}"
else
    echo -e "${RED}✗ Claude Code non trovato${NC}"
    echo -e "${YELLOW}Installa Claude Code con: npm install -g @anthropic-ai/claude-code${NC}"
    exit 1
fi

# Create directory structure
echo -e "${YELLOW}Creazione directory...${NC}"
mkdir -p ~/.claude/backups
mkdir -p ~/.claude/configs
echo -e "${GREEN}✓ Directory create${NC}"

# Copy scripts
echo -e "${YELLOW}Installazione script...${NC}"

# Copy main switcher (optional)
if [ -f "claude-code-glm-switcher.sh" ]; then
    cp claude-code-glm-switcher.sh ~/.claude/switch-model.sh
    chmod +x ~/.claude/switch-model.sh
    echo -e "${GREEN}✓ Script switch-model.sh installato${NC}"
fi

# Copy launch scripts
if [ -f "launch-with-glm.sh" ]; then
    cp launch-with-glm.sh ~/.claude/
    chmod +x ~/.claude/launch-with-glm.sh
    echo -e "${GREEN}✓ Script launch-with-glm.sh installato${NC}"
else
    echo -e "${RED}✗ launch-with-glm.sh non trovato${NC}"
fi

if [ -f "launch-with-glm-air.sh" ]; then
    cp launch-with-glm-air.sh ~/.claude/
    chmod +x ~/.claude/launch-with-glm-air.sh
    echo -e "${GREEN}✓ Script launch-with-glm-air.sh installato${NC}"
else
    echo -e "${RED}✗ launch-with-glm-air.sh non trovato${NC}"
fi

# Detect shell
if [ -n "$BASH_VERSION" ]; then
    SHELL_RC="$HOME/.bashrc"
    SHELL_NAME="bash"
elif [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
    SHELL_NAME="zsh"
else
    SHELL_RC="$HOME/.profile"
    SHELL_NAME="sh"
fi

# Add aliases
echo -e "${YELLOW}Aggiunta alias a $SHELL_NAME...${NC}"

# Remove old aliases if they exist
sed -i '/# Claude Code - GLM Switcher/d' "$SHELL_RC" 2>/dev/null || true
sed -i '/alias claude-glm=/d' "$SHELL_RC" 2>/dev/null || true
sed -i '/alias claude-switch=/d' "$SHELL_RC" 2>/dev/null || true
sed -i '/alias use-glm=/d' "$SHELL_RC" 2>/dev/null || true
sed -i '/alias use-claude=/d' "$SHELL_RC" 2>/dev/null || true

# Add new aliases
cat >> "$SHELL_RC" << 'EOL'

# Claude Code - GLM Switcher
# Comandi diretti per ogni modello
alias claude-glm='~/.claude/launch-with-glm.sh'        # GLM-4.7 (Opus/Sonnet)
alias claude-glm-air='~/.claude/launch-with-glm-air.sh' # GLM-4.5-Air (Haiku fast)
alias claude-switch='~/.claude/switch-model.sh'         # Menu interattivo (opzionale)
EOL

echo -e "${GREEN}✓ Alias aggiunti${NC}"

# Ask about API key
echo
echo -e "${BLUE}═══════════════════════════════════════════${NC}"
echo -e "${YELLOW}Configurazione API Key Z.AI${NC}"
echo -e "${BLUE}═══════════════════════════════════════════${NC}"
echo
echo -e "Hai già una API key di Z.AI? (y/n)"
read -r has_key

if [[ "$has_key" == "y" ]]; then
    echo -e "${YELLOW}Inserisci la tua API key Z.AI:${NC}"
    read -r api_key

    # Update the launch scripts with the API key
    sed -i "s/export ANTHROPIC_AUTH_TOKEN=.*/export ANTHROPIC_AUTH_TOKEN=\"$api_key\"/" ~/.claude/launch-with-glm.sh
    sed -i "s/export ANTHROPIC_AUTH_TOKEN=.*/export ANTHROPIC_AUTH_TOKEN=\"$api_key\"/" ~/.claude/launch-with-glm-air.sh

    echo -e "${GREEN}✓ API key configurata${NC}"
else
    echo -e "${YELLOW}Puoi ottenere una API key gratuita da: ${CYAN}https://z.ai${NC}"
    echo -e "${YELLOW}Dopo averla ottenuta, modificala in:${NC}"
    echo -e "  ~/.claude/launch-with-glm.sh"
    echo -e "  ~/.claude/launch-with-glm-air.sh"
fi

# Success message
echo
echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     Installazione completata! 🎉         ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
echo
echo -e "${CYAN}Comandi disponibili dopo aver ricaricato il terminale:${NC}"
echo
echo -e "  ${GREEN}claude${NC}         - Usa Claude Sonnet 4.5 / Opus 4.1 (Anthropic)"
echo -e "  ${GREEN}claude-glm${NC}     - Usa GLM-4.7 (Z.AI) - Opus/Sonnet replacement"
echo -e "  ${GREEN}claude-glm-air${NC} - Usa GLM-4.5-Air (Z.AI) - Haiku replacement"
echo -e "  ${GREEN}claude-switch${NC}  - Menu interattivo (opzionale)"
echo
echo -e "${YELLOW}Per attivare i comandi:${NC}"
echo -e "  source $SHELL_RC"
echo
echo -e "${BLUE}Risparmia 85% sui costi usando GLM!${NC}"
echo