#!/bin/bash

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

SETTINGS_FILE="$HOME/.claude/settings.json"
BASHRC_FILE="$HOME/.bashrc"
BACKUP_DIR="$HOME/.claude/configs"

# Crea directory per backup configurazioni se non esiste
mkdir -p "$BACKUP_DIR"

function show_menu() {
    echo -e "${BLUE}═══════════════════════════════════════════${NC}"
    echo -e "${GREEN}   Claude Code Model Switcher${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════${NC}"
    echo
    echo -e "${YELLOW}Modelli GLM (Z.AI):${NC}"
    echo "  1) GLM-4.6 (Dialog, Planning, Coding)"
    echo "  2) GLM-4.5-Air (File Search, Syntax Check)"
    echo
    echo -e "${YELLOW}Modelli Claude (Anthropic):${NC}"
    echo "  3) Claude Opus 4.1"
    echo "  4) Claude Sonnet 4.5"
    echo
    echo -e "${CYAN}Gestione configurazione:${NC}"
    echo "  5) Disabilita variabili GLM in .bashrc"
    echo "  6) Riabilita variabili GLM in .bashrc"
    echo "  7) Mostra stato dettagliato"
    echo
    echo "  0) Esci"
    echo
    echo -e "${BLUE}═══════════════════════════════════════════${NC}"
    echo -n "Scegli [0-7]: "
}

function comment_bashrc_vars() {
    echo -e "${YELLOW}Disabilitando variabili GLM in .bashrc...${NC}"
    
    # Backup
    cp "$BASHRC_FILE" "$BASHRC_FILE.bak.$(date +%Y%m%d_%H%M%S)"
    
    # Commenta le variabili ANTHROPIC
    sed -i 's/^export ANTHROPIC_AUTH_TOKEN=/# export ANTHROPIC_AUTH_TOKEN=/' "$BASHRC_FILE"
    sed -i 's/^export ANTHROPIC_MODEL=/# export ANTHROPIC_MODEL=/' "$BASHRC_FILE"
    sed -i 's/^export ANTHROPIC_BASE_URL=/# export ANTHROPIC_BASE_URL=/' "$BASHRC_FILE"
    sed -i 's/^export ANTHROPIC_SMALL_FAST_MODEL=/# export ANTHROPIC_SMALL_FAST_MODEL=/' "$BASHRC_FILE"
    
    # Pulisci dalla sessione corrente
    unset ANTHROPIC_BASE_URL
    unset ANTHROPIC_MODEL
    unset ANTHROPIC_SMALL_FAST_MODEL
    unset ANTHROPIC_AUTH_TOKEN
    
    echo -e "${GREEN}✓ Variabili GLM disabilitate${NC}"
    echo -e "${YELLOW}Ricarica il terminale o esegui: source ~/.bashrc${NC}"
}

function uncomment_bashrc_vars() {
    echo -e "${YELLOW}Riabilitando variabili GLM in .bashrc...${NC}"
    
    # Decommenta le variabili ANTHROPIC
    sed -i 's/^# export ANTHROPIC_AUTH_TOKEN=/export ANTHROPIC_AUTH_TOKEN=/' "$BASHRC_FILE"
    sed -i 's/^# export ANTHROPIC_MODEL=/export ANTHROPIC_MODEL=/' "$BASHRC_FILE"
    sed -i 's/^# export ANTHROPIC_BASE_URL=/export ANTHROPIC_BASE_URL=/' "$BASHRC_FILE"
    sed -i 's/^# export ANTHROPIC_SMALL_FAST_MODEL=/export ANTHROPIC_SMALL_FAST_MODEL=/' "$BASHRC_FILE"
    
    # Ricarica
    source "$BASHRC_FILE"
    
    echo -e "${GREEN}✓ Variabili GLM riabilitate${NC}"
}

function switch_to_glm() {
    local model=$1
    echo -e "${YELLOW}Configurando per GLM model: $model${NC}"
    
    # Decommenta le variabili nel .bashrc
    sed -i 's/^# export ANTHROPIC_AUTH_TOKEN=/export ANTHROPIC_AUTH_TOKEN=/' "$BASHRC_FILE"
    sed -i 's/^# export ANTHROPIC_MODEL=/export ANTHROPIC_MODEL=/' "$BASHRC_FILE"
    sed -i 's/^# export ANTHROPIC_BASE_URL=/export ANTHROPIC_BASE_URL=/' "$BASHRC_FILE"
    sed -i 's/^# export ANTHROPIC_SMALL_FAST_MODEL=/export ANTHROPIC_SMALL_FAST_MODEL=/' "$BASHRC_FILE"
    
    # IMPORTANTE: Esporta ANCHE nella sessione corrente
    export ANTHROPIC_AUTH_TOKEN="0617f0ac31984956b718230df9410e25.DTSvGQvXuyUiFOb1"
    export ANTHROPIC_MODEL="glm-4.6"
    export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic"
    export ANTHROPIC_SMALL_FAST_MODEL="glm-4.5-air"
    
    # Aggiorna settings.json
    cat > "$SETTINGS_FILE" <<EOF
{
  "apiBaseUrl": "https://api.z.ai/api/anthropic",
  "apiTimeout": 3000000,
  "model": "$model",
  "ANTHROPIC_MODEL": "glm-4.6",
  "ANTHROPIC_SMALL_FAST_MODEL": "glm-4.5-air"
}
EOF
    
    echo -e "${GREEN}✓ Configurato per GLM $model${NC}"
    echo -e "${BLUE}API URL: https://api.z.ai/api/anthropic${NC}"
    echo
    echo -e "${YELLOW}IMPORTANTE:${NC}"
    echo "1. Esegui: ${GREEN}source ~/.bashrc${NC} per rendere permanente"
    echo "2. Oppure lancia direttamente: ${GREEN}claude${NC}"
    echo
    echo -e "${CYAN}Le variabili sono attive in QUESTA sessione${NC}"
}

function switch_to_claude() {
    local model=$1
    local model_name=$2
    echo -e "${YELLOW}Configurando per Claude $model_name${NC}"
    
    # Disabilita variabili GLM
    comment_bashrc_vars
    
    # Aggiorna settings.json per Claude originale
    cat > "$SETTINGS_FILE" <<EOF
{
  "apiBaseUrl": "https://api.anthropic.com",
  "apiTimeout": 300000,
  "model": "$model"
}
EOF
    
    echo -e "${GREEN}✓ Configurato per Claude $model_name${NC}"
    echo -e "${BLUE}API URL: https://api.anthropic.com${NC}"
    echo
    echo -e "${YELLOW}IMPORTANTE:${NC}"
    echo "1. Esegui: ${GREEN}source ~/.bashrc${NC} per ricaricare la configurazione"
    echo "2. Poi esegui: ${GREEN}claude${NC} per avviare"
    echo "3. Se richiesto, effettua il login con il tuo account Claude Max"
}

function show_detailed_status() {
    clear
    echo -e "${BLUE}═══════════════════════════════════════════${NC}"
    echo -e "${GREEN}   STATO DETTAGLIATO CONFIGURAZIONE${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════${NC}"
    
    echo
    echo -e "${YELLOW}1. Variabili d'ambiente in sessione:${NC}"
    echo -n "   ANTHROPIC_BASE_URL: "
    if [ -n "$ANTHROPIC_BASE_URL" ]; then
        echo -e "${RED}$ANTHROPIC_BASE_URL${NC}"
    else
        echo -e "${GREEN}Non definita${NC}"
    fi
    echo -n "   ANTHROPIC_MODEL: "
    if [ -n "$ANTHROPIC_MODEL" ]; then
        echo -e "${RED}$ANTHROPIC_MODEL${NC}"
    else
        echo -e "${GREEN}Non definita${NC}"
    fi
    
    echo
    echo -e "${YELLOW}2. Stato in ~/.bashrc:${NC}"
    if grep -q "^export ANTHROPIC_" "$BASHRC_FILE"; then
        echo -e "   ${RED}Variabili GLM ATTIVE in .bashrc${NC}"
        grep "^export ANTHROPIC_" "$BASHRC_FILE" | sed 's/^/   /'
    elif grep -q "^# export ANTHROPIC_" "$BASHRC_FILE"; then
        echo -e "   ${GREEN}Variabili GLM DISABILITATE (commentate) in .bashrc${NC}"
    else
        echo -e "   ${CYAN}Nessuna variabile ANTHROPIC trovata in .bashrc${NC}"
    fi
    
    echo
    echo -e "${YELLOW}3. Settings.json:${NC}"
    if [ -f "$SETTINGS_FILE" ]; then
        cat "$SETTINGS_FILE" | python3 -m json.tool | sed 's/^/   /'
    else
        echo -e "   ${RED}File non trovato${NC}"
    fi
}

function show_current_status() {
    echo
    if [ -n "$ANTHROPIC_BASE_URL" ]; then
        echo -e "${RED}⚠ ATTENZIONE: Variabili GLM attive nella sessione${NC}"
        echo -e "  Model: $ANTHROPIC_MODEL"
        echo -e "  URL: $ANTHROPIC_BASE_URL"
    else
        echo -e "${GREEN}✓ Nessuna variabile GLM attiva${NC}"
    fi
    echo
}

# Main loop
while true; do
    clear
    show_current_status
    show_menu
    read choice
    
    case $choice in
        1)
            switch_to_glm "glm-4.6"
            ;;
        2)
            switch_to_glm "glm-4.5-air"
            ;;
        3)
            switch_to_claude "claude-opus-4-1-20250805" "Opus 4.1"
            ;;
        4)
            switch_to_claude "claude-sonnet-4-5-20250929" "Sonnet 4.5"
            ;;
        5)
            comment_bashrc_vars
            ;;
        6)
            uncomment_bashrc_vars
            ;;
        7)
            show_detailed_status
            ;;
        0)
            echo -e "${GREEN}Arrivederci!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Scelta non valida!${NC}"
            ;;
    esac
    
    if [ "$choice" -ge 1 ] && [ "$choice" -le 7 ]; then
        echo
        echo -e "${GREEN}Premi ENTER per continuare...${NC}"
        read
    fi
done
