#!/bin/bash

# ============================================
# Claude Code - GLM Switcher v2.0
# Seamlessly switch between GLM-4.5 and Claude models
# ============================================

# Color codes for better UI
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Configuration paths
SETTINGS_FILE="$HOME/.claude/settings.json"
ENV_FILE="$HOME/.env"
BACKUP_DIR="$HOME/.claude/backups"
LOG_FILE="$HOME/.claude/switcher.log"

# Create necessary directories
mkdir -p "$BACKUP_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

# Logging function
log_action() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Backup current configuration
backup_config() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    if [ -f "$SETTINGS_FILE" ]; then
        cp "$SETTINGS_FILE" "$BACKUP_DIR/settings_$timestamp.json"
        log_action "Backed up settings to settings_$timestamp.json"
    fi
}

# Display current status
show_status() {
    echo -e "${CYAN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║        Current Configuration Status       ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════╝${NC}"
    
    if [ -f "$SETTINGS_FILE" ]; then
        local current_url=$(grep -o '"apiBaseUrl":[^,]*' "$SETTINGS_FILE" | cut -d'"' -f4)
        local current_model=$(grep -o '"model":[^,]*' "$SETTINGS_FILE" | cut -d'"' -f4)
        
        if [[ "$current_url" == *"z.ai"* ]]; then
            echo -e "${GREEN}  ✓ Mode: GLM-4.5 (Z.AI)${NC}"
            echo -e "${GREEN}  ✓ Model: $current_model${NC}"
            echo -e "${GREEN}  ✓ API: $current_url${NC}"
        elif [[ "$current_url" == *"anthropic"* ]]; then
            echo -e "${BLUE}  ✓ Mode: Claude (Anthropic)${NC}"
            echo -e "${BLUE}  ✓ Model: $current_model${NC}"
            echo -e "${BLUE}  ✓ API: $current_url${NC}"
        else
            echo -e "${YELLOW}  ⚠ Unknown configuration${NC}"
        fi
    else
        echo -e "${RED}  ✗ No configuration file found${NC}"
    fi
    echo
}

# Main menu
show_menu() {
    echo -e "${MAGENTA}╔══════════════════════════════════════════╗${NC}"
    echo -e "${MAGENTA}║    Claude Code - GLM Switcher v2.0       ║${NC}"
    echo -e "${MAGENTA}╚══════════════════════════════════════════╝${NC}"
    echo
    echo -e "${YELLOW}GLM-4.5 Models (Z.AI):${NC}"
    echo "  1) GLM-4.5 (Full - Best for complex tasks)"
    echo "  2) GLM-4.5-Air (Fast - Best for quick tasks)"
    echo
    echo -e "${BLUE}Claude Models (Anthropic):${NC}"
    echo "  3) Claude Opus 4.1 (Most capable)"
    echo "  4) Claude Sonnet 4.0 (Balanced)"
    echo
    echo -e "${CYAN}Utilities:${NC}"
    echo "  5) Show detailed configuration"
    echo "  6) Backup current configuration"
    echo "  7) Restore from backup"
    echo "  8) View usage statistics"
    echo
    echo "  0) Exit"
    echo
    echo -e "${MAGENTA}════════════════════════════════════════════${NC}"
    echo -n "Select an option [0-8]: "
}

# Configure for GLM models
configure_glm() {
    local model=$1
    local model_name=$2
    
    echo -e "${YELLOW}Configuring for $model_name...${NC}"
    backup_config
    
    # Check for existing API key
    if [ -f "$HOME/.claude/glm_api_key" ]; then
        echo -e "${GREEN}Using existing GLM API key${NC}"
    else
        echo -n "Enter your Z.AI API key (or press Enter to skip): "
        read -s api_key
        echo
        
        if [ -n "$api_key" ]; then
            echo "$api_key" > "$HOME/.claude/glm_api_key"
            chmod 600 "$HOME/.claude/glm_api_key"
            echo -e "${GREEN}API key saved${NC}"
        fi
    fi
    
    # Create settings.json
    cat > "$SETTINGS_FILE" <<EOF
{
  "apiBaseUrl": "https://api.z.ai/api/anthropic",
  "apiTimeout": 3000000,
  "model": "$model",
  "modelOverrides": {
    "ANTHROPIC_MODEL": "glm-4.5",
    "ANTHROPIC_SMALL_FAST_MODEL": "glm-4.5-air"
  },
  "features": {
    "thinking_mode": true,
    "web_search": true,
    "file_operations": true
  }
}
EOF
    
    # Set environment variables
    if [ -f "$HOME/.claude/glm_api_key" ]; then
        local stored_key=$(cat "$HOME/.claude/glm_api_key")
        cat > "$ENV_FILE" <<EOF
# GLM-4.5 Configuration
export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic"
export ANTHROPIC_MODEL="$model"
export ANTHROPIC_API_KEY="$stored_key"
EOF
    else
        cat > "$ENV_FILE" <<EOF
# GLM-4.5 Configuration
export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic"
export ANTHROPIC_MODEL="$model"
# Add your API key here:
# export ANTHROPIC_API_KEY="YOUR_API_KEY_HERE"
EOF
    fi
    
    log_action "Configured for $model_name"
    echo -e "${GREEN}✓ Successfully configured for $model_name${NC}"
    echo -e "${CYAN}To apply changes, run: ${NC}source $ENV_FILE"
}

# Configure for Claude models
configure_claude() {
    local model=$1
    local model_name=$2
    
    echo -e "${BLUE}Configuring for $model_name...${NC}"
    backup_config
    
    # Create settings.json for Claude
    cat > "$SETTINGS_FILE" <<EOF
{
  "apiBaseUrl": "https://api.anthropic.com",
  "apiTimeout": 300000,
  "model": "$model",
  "features": {
    "thinking_mode": true,
    "web_search": true,
    "file_operations": true
  }
}
EOF
    
    # Clear GLM environment variables
    cat > "$ENV_FILE" <<EOF
# Claude Native Configuration
unset ANTHROPIC_BASE_URL
unset ANTHROPIC_MODEL
unset ANTHROPIC_API_KEY
# Note: You'll need to authenticate with Claude directly
EOF
    
    log_action "Configured for $model_name"
    echo -e "${GREEN}✓ Successfully configured for $model_name${NC}"
    echo -e "${YELLOW}Note: You'll need to authenticate with your Claude account${NC}"
    echo -e "${CYAN}To apply changes, run: ${NC}source $ENV_FILE"
}

# Show detailed configuration
show_detailed_config() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║       Detailed Configuration Report       ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════╝${NC}"
    echo
    
    echo -e "${YELLOW}Settings File ($SETTINGS_FILE):${NC}"
    if [ -f "$SETTINGS_FILE" ]; then
        if command -v python3 &> /dev/null; then
            cat "$SETTINGS_FILE" | python3 -m json.tool 2>/dev/null || cat "$SETTINGS_FILE"
        else
            cat "$SETTINGS_FILE"
        fi
    else
        echo -e "${RED}  File not found${NC}"
    fi
    
    echo
    echo -e "${YELLOW}Environment Variables:${NC}"
    env | grep ANTHROPIC | sed 's/^/  /' || echo "  No ANTHROPIC variables set"
    
    echo
    echo -e "${YELLOW}API Key Status:${NC}"
    if [ -f "$HOME/.claude/glm_api_key" ]; then
        echo -e "${GREEN}  ✓ GLM API key configured${NC}"
    else
        echo -e "${RED}  ✗ No GLM API key found${NC}"
    fi
    
    echo
    echo -e "${YELLOW}Backup Files:${NC}"
    if [ -d "$BACKUP_DIR" ]; then
        ls -la "$BACKUP_DIR" 2>/dev/null | tail -5 | sed 's/^/  /'
    else
        echo "  No backups found"
    fi
}

# Restore from backup
restore_backup() {
    echo -e "${CYAN}Available backups:${NC}"
    if [ -d "$BACKUP_DIR" ] && [ "$(ls -A $BACKUP_DIR)" ]; then
        select backup in "$BACKUP_DIR"/*.json; do
            if [ -f "$backup" ]; then
                cp "$backup" "$SETTINGS_FILE"
                echo -e "${GREEN}✓ Restored from $(basename $backup)${NC}"
                log_action "Restored from $(basename $backup)"
                break
            else
                echo -e "${RED}Invalid selection${NC}"
            fi
        done
    else
        echo -e "${RED}No backups available${NC}"
    fi
}

# Show usage statistics
show_usage_stats() {
    echo -e "${CYAN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║          Usage Statistics                ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════╝${NC}"
    echo
    
    if [ -f "$LOG_FILE" ]; then
        echo -e "${YELLOW}Recent Activity:${NC}"
        tail -10 "$LOG_FILE" | sed 's/^/  /'
        
        echo
        echo -e "${YELLOW}Configuration Changes Today:${NC}"
        grep "$(date '+%Y-%m-%d')" "$LOG_FILE" | grep "Configured for" | tail -5 | sed 's/^/  /'
        
        echo
        echo -e "${YELLOW}Total Switches:${NC}"
        local total_switches=$(grep -c "Configured for" "$LOG_FILE" 2>/dev/null || echo "0")
        echo "  Total model switches: $total_switches"
    else
        echo -e "${RED}No usage data available${NC}"
    fi
}

# Main execution loop
main() {
    while true; do
        clear
        show_status
        show_menu
        
        read choice
        case $choice in
            1)
                configure_glm "glm-4.5" "GLM-4.5 (Full)"
                ;;
            2)
                configure_glm "glm-4.5-air" "GLM-4.5-Air (Fast)"
                ;;
            3)
                configure_claude "claude-opus-4-1-20250805" "Claude Opus 4.1"
                ;;
            4)
                configure_claude "claude-sonnet-4-20250514" "Claude Sonnet 4.0"
                ;;
            5)
                show_detailed_config
                ;;
            6)
                backup_config
                echo -e "${GREEN}✓ Configuration backed up${NC}"
                ;;
            7)
                restore_backup
                ;;
            8)
                show_usage_stats
                ;;
            0)
                echo -e "${GREEN}Goodbye!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid option${NC}"
                ;;
        esac
        
        if [ "$choice" != "0" ]; then
            echo
            echo -e "${CYAN}Press Enter to continue...${NC}"
            read
        fi
    done
}

# Check if being sourced or executed
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    # Script is being executed
    main
fi
