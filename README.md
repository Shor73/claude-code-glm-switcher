# Claude Code - GLM Switcher 🚀

> Usa Claude Code con modelli GLM-4.6 o Claude nativi - Cambia al volo con comandi dedicati!

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GLM-4.6](https://img.shields.io/badge/GLM--4.6-Supported-green.svg)](https://z.ai)
[![Claude Sonnet 4.5](https://img.shields.io/badge/Claude%20Sonnet%204.5-Latest-blue.svg)](https://claude.ai)

## 🎯 Cosa fa questo progetto?

Ti permette di usare **Claude Code** con:
- **Modelli Claude originali** (Opus 4.1, Sonnet 4.5) tramite Anthropic API
- **Modelli GLM** (GLM-4.6, GLM-4.5-Air) tramite Z.AI API - **RISPARMIA 85%!**

### La Nuova Filosofia: Un Comando per Ogni Modello

```bash
claude         # Usa Claude Sonnet 4.5 / Opus 4.1 (Anthropic)
claude-glm     # Usa GLM-4.6 (Z.AI)
claude-glm-air # Usa GLM-4.5-Air Fast (Z.AI)
```

**Nessuno switch manuale!** Ogni comando lancia Claude Code con il modello giusto automaticamente.

## 🚀 Installazione Rapida (2 minuti)

### Prerequisiti
- Linux, macOS, o WSL2 su Windows
- Claude Code installato (`npm install -g @anthropic-ai/claude-code`)

### Setup Automatico

```bash
# Clona il repository
git clone https://github.com/Shor73/claude-code-glm-switcher.git
cd claude-code-glm-switcher

# Esegui l'installer
./install.sh
```

L'installer:
1. Copia gli script nella directory `~/.claude/`
2. Aggiunge gli alias al tuo `.bashrc`
3. Configura tutto automaticamente

### Dopo l'installazione

```bash
# Ricarica il terminale
source ~/.bashrc

# Ora puoi usare:
claude         # Per modelli Anthropic
claude-glm     # Per GLM-4.6
claude-glm-air # Per GLM-4.5-Air
```

## 📖 Come Funziona

### Architettura Semplificata

Invece di modificare variabili d'ambiente globali, ogni comando usa il suo script dedicato:

```
claude-glm → launch-with-glm.sh → Setta variabili GLM → Lancia Claude Code
claude → Nessuna variabile extra → Usa API Anthropic nativa
```

### I Tre Script Principali

1. **`launch-with-glm.sh`**
   - Setta: `ANTHROPIC_MODEL="glm-4.6"`
   - API: `https://api.z.ai/api/anthropic`
   - Ideale per: Coding complesso, analisi approfondite

2. **`launch-with-glm-air.sh`**
   - Setta: `ANTHROPIC_MODEL="glm-4.5-air"`
   - API: `https://api.z.ai/api/anthropic`
   - Ideale per: Ricerche veloci, file search, syntax check

3. **Claude nativo** (nessuno script)
   - Usa i modelli Anthropic originali
   - Nessuna configurazione extra

## 💰 Perché Usare GLM?

### Confronto Costi

| Servizio | Costo Mensile | Risparmio |
|----------|--------------|-----------|
| Claude Pro | $20 | - |
| Claude Max | $200 | - |
| **GLM-4.6 via Z.AI** | **$3** | **85-98%** |

### Prestazioni GLM-4.6

- **Parametri**: 355B totali (32B attivi via MoE)
- **Context**: 128K token
- **Ranking**: #3 globalmente nei benchmark
- **Specialità**: Eccellente in coding, tool use (90.6% success rate)

## 🔧 Menu Opzionale (claude-switch)

Se preferisci un menu interattivo, puoi ancora usare:

```bash
claude-switch
```

Questo mostra un menu per:
- Switchare tra modelli
- Vedere lo stato corrente
- Gestire le configurazioni

**MA NON È PIÙ NECESSARIO!** I nuovi comandi `claude-glm` e `claude` sono più diretti.

## 🛠️ Configurazione Manuale

Se vuoi configurare manualmente:

### 1. Copia gli script

```bash
mkdir -p ~/.claude
cp launch-with-glm.sh ~/.claude/
cp launch-with-glm-air.sh ~/.claude/
chmod +x ~/.claude/launch-*.sh
```

### 2. Aggiungi gli alias

```bash
echo 'alias claude-glm="~/.claude/launch-with-glm.sh"' >> ~/.bashrc
echo 'alias claude-glm-air="~/.claude/launch-with-glm-air.sh"' >> ~/.bashrc
source ~/.bashrc
```

### 3. Configura l'API Key di Z.AI

Modifica `launch-with-glm.sh` e inserisci la tua API key:
```bash
export ANTHROPIC_AUTH_TOKEN="tua-api-key-qui"
```

Ottieni la key da: https://z.ai

## 📊 Modelli Disponibili

### Via Anthropic (comando `claude`)
- **Claude Opus 4.1** - Il più potente
- **Claude Sonnet 4.5** - Bilanciato, ottimo per coding

### Via Z.AI (comandi `claude-glm*`)
- **GLM-4.6** - Modello principale, eccellente per tutto
- **GLM-4.5-Air** - Velocissimo, perfetto per task semplici

## 🎯 Quando Usare Cosa

| Usa questo comando | Quando vuoi |
|-------------------|-------------|
| `claude` | Massima qualità, non ti interessa il costo |
| `claude-glm` | Risparmiare 85% mantenendo qualità eccellente |
| `claude-glm-air` | Risposte immediate per task semplici |

## 🐛 Troubleshooting

### "comando non trovato"
```bash
source ~/.bashrc  # Ricarica la configurazione
```

### "API key non valida"
Modifica `~/.claude/launch-with-glm.sh` e inserisci la tua key Z.AI

### Voglio cambiare modello GLM di default
Modifica `ANTHROPIC_MODEL` in `~/.claude/launch-with-glm.sh`

## 🤝 Contribuire

PR benvenuti! Specialmente per:
- Supporto per altri modelli open (Llama, Mistral)
- GUI per configurazione
- Integrazione VS Code

## 📄 Licenza

MIT - Vedi [LICENSE](LICENSE)

## 🙏 Ringraziamenti

- [Zhipu AI](https://z.ai) per GLM-4.6
- [Anthropic](https://anthropic.com) per Claude Code
- La community open source

## ⭐ Supporta il Progetto

Se questo progetto ti fa risparmiare soldi, considera di mettere una stella ⭐!

---

<p align="center">
  <b>Risparmia. Switcha. Programma.</b>
</p>