#!/bin/bash
# Lancia Claude Code con modello GLM-4.5-Air (Haiku - Fast model)
# Questo modello è ottimizzato per ricerche veloci e operazioni di file search
# tramite l'API di Z.AI

export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-4.7"
export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"
export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic"
export ANTHROPIC_AUTH_TOKEN="0617f0ac31984956b718230df9410e25.DTSvGQvXuyUiFOb1"

# Lancia Claude Code passando tutti gli argomenti
exec claude "$@"
