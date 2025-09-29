#!/bin/bash

# Claude Code - GLM Switcher Installer
# This script sets up the model switcher for Claude Code

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Claude Code - GLM Switcher Installer    ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════╝${NC}"
echo

# Check prerequisites
echo -e "${YELLOW}Checking prerequisites...${NC}"

# Check Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v | cut -d'v' -f2)
    echo -e "${GREEN}✓ Node.js installed (v$NODE_VERSION)${NC}"
else
    echo -e "${RED}✗ Node.js not found. Please install Node.js v20.0+${NC}"
    exit 1
fi

# Check Claude Code
if command -v claude &> /dev/null; then
    echo -e "${GREEN}✓ Claude Code installed${NC}"
else
    echo -e "${YELLOW}Claude Code not found. Would you like to install it? (y/n)${NC}"
    read -r install_claude
    if [[ "$install_claude" == "y" ]]; then
        echo -e "${BLUE}Installing Claude Code...${NC}"
        npm install -g @claude/code
    else
        echo -e "${RED}Claude Code is required. Please install it manually:${NC}"
        echo "npm install -g @claude/code"
        exit 1
    fi
fi

# Create directory structure
echo -e "${YELLOW}Setting up directories...${NC}"
mkdir -p ~/.claude/backups
mkdir -p ~/.claude/configs
echo -e "${GREEN}✓ Directories created${NC}"

# Copy main script
echo -e "${YELLOW}Installing Claude Code - GLM Switcher...${NC}"
cp claude-code-glm-switcher.sh ~/.claude/
chmod +x ~/.claude/claude-code-glm-switcher.sh
echo -e "${GREEN}✓ Script installed${NC}"

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
echo -e "${YELLOW}Adding aliases to $SHELL_NAME...${NC}"

# Check if aliases already exist
if ! grep -q "claude-glm" "$SHELL_RC" 2>/dev/null; then
    cat >> "$SHELL_RC" << 'EOL'

# Claude Code
