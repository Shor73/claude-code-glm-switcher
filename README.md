# Claude Code - GLM Switcher 🚀

> Use Claude Code with GLM-5 or native Claude models - Switch instantly with dedicated commands!

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GLM-5](https://img.shields.io/badge/GLM--5-Supported-green.svg)](https://z.ai)
[![Claude Sonnet 4.5](https://img.shields.io/badge/Claude%20Sonnet%204.5-Latest-blue.svg)](https://claude.ai)

## 🎯 What is this?

This tool lets you use **Claude Code** with:
- **Native Claude models** (Opus 4.1, Sonnet 4.5) via Anthropic API
- **GLM models** (GLM-5, GLM-4.5-Air) via Z.AI API - **SAVE 85%!**

### Model Mapping
- **GLM-5** → replaces Claude Opus & Sonnet (main coding/model)
- **GLM-4.5-Air** → replaces Claude Haiku (fast model)

### The New Philosophy: One Command Per Model

```bash
claude         # Use Claude Sonnet 4.5 / Opus 4.1 (Anthropic)
claude-glm     # Use GLM-5 (Z.AI) - Opus/Sonnet replacement
claude-glm-air # Use GLM-4.5-Air (Z.AI) - Haiku replacement
```

**No manual switching!** Each command launches Claude Code with the right model automatically.

## 🚀 Quick Install (2 minutes)

### Prerequisites
- Linux, macOS, or WSL2 on Windows
- Claude Code installed (`npm install -g @anthropic-ai/claude-code`)

### Automatic Setup

```bash
# Clone the repository
git clone https://github.com/Shor73/claude-code-glm-switcher.git
cd claude-code-glm-switcher

# Run the installer
./install.sh
```

The installer will:
1. Copy scripts to `~/.claude/` directory
2. Add aliases to your `.bashrc`
3. Configure everything automatically

### After Installation

```bash
# Reload your terminal
source ~/.bashrc

# Now you can use:
claude         # For Anthropic models
claude-glm     # For GLM-5 (Opus/Sonnet replacement)
claude-glm-air # For GLM-4.5-Air (Haiku replacement)
```

## 📖 How It Works

### Simplified Architecture

Instead of modifying global environment variables, each command uses its own dedicated script:

```
claude-glm → launch-with-glm.sh → Sets GLM variables → Launches Claude Code
claude → No extra variables → Uses native Anthropic API
```

### The Three Main Scripts

1. **`launch-with-glm.sh`**
   - Sets: `ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5"`, `ANTHROPIC_DEFAULT_SONNET_MODEL="glm-5"`, `ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"`
   - API: `https://api.z.ai/api/anthropic`
   - Best for: Complex coding, deep analysis

2. **`launch-with-glm-air.sh`**
   - Sets: Same as above (GLM-5 for Opus/Sonnet, GLM-4.5-Air for Haiku)
   - API: `https://api.z.ai/api/anthropic`
   - Best for: Quick searches, file search, syntax checks

3. **Native Claude** (no script needed)
   - Uses original Anthropic models
   - No extra configuration

## 💰 Why Use GLM?

### Cost Comparison

| Service | Monthly Cost | Savings |
|---------|--------------|---------|
| Claude Pro | $20 | - |
| Claude Max | $200 | - |
| **GLM-5 via Z.AI** | **$3** | **85-98%** |

### GLM-5 Performance

- **Latest model** from Zhipu AI (replaces GLM-4.7)
- **Context**: 200K tokens (was 128K)
- **Max Output**: 128K tokens
- **Ranking**: Top-tier globally in benchmarks
- **Specialty**: Excellent at coding, tool use, planning

#### ✨ GLM-5 New Features

| Feature | Description |
|---------|-------------|
| **Extended Context** | 200K tokens for larger projects |
| **Deep Thinking** | `thinking={ type: "enabled" }` for complex reasoning |
| **Streaming Tool Calls** | `tool_stream=true` for real-time tool output |
| **Superior Code Performance** | Better at coding and advanced reasoning |

#### 🔧 Advanced Configuration (Optional)

Add to `~/.claude/settings.json` for custom behavior:
```json
{
  "temperature": 1.0,
  "top_p": 0.95
}
```

> **Note**: Only tune `temperature` OR `top_p`, not both simultaneously.

### GLM-4.5-Air Performance

- **Fast model** optimized for quick tasks
- **Perfect for**: File search, syntax checks, simple queries
- **Cost-effective**: Ultra-low latency responses

## 🔧 Optional Menu (claude-switch)

If you prefer an interactive menu, you can still use:

```bash
claude-switch
```

This shows a menu to:
- Switch between models
- View current status
- Manage configurations

**BUT IT'S NOT NECESSARY!** The new `claude-glm` and `claude` commands are more direct.

## 🛠️ Manual Configuration

If you want to configure manually:

### 1. Copy the scripts

```bash
mkdir -p ~/.claude
cp launch-with-glm.sh ~/.claude/
cp launch-with-glm-air.sh ~/.claude/
chmod +x ~/.claude/launch-*.sh
```

### 2. Add aliases

```bash
echo 'alias claude-glm="~/.claude/launch-with-glm.sh"' >> ~/.bashrc
echo 'alias claude-glm-air="~/.claude/launch-with-glm-air.sh"' >> ~/.bashrc
source ~/.bashrc
```

### 3. Configure Z.AI API Key

Edit `launch-with-glm.sh` and insert your API key:
```bash
export ANTHROPIC_AUTH_TOKEN="your-api-key-here"
```

Get your key from: https://z.ai

## 📊 Available Models

### Via Anthropic (command `claude`)
- **Claude Opus 4.1** - Most powerful
- **Claude Sonnet 4.5** - Balanced, great for coding

### Via Z.AI (commands `claude-glm*`)
- **GLM-5** - Main model (replaces GLM-4.7), excellent for everything
- **GLM-4.5-Air** - Lightning fast, perfect for simple tasks

## 🎯 When to Use What

| Use this command | When you want |
|------------------|---------------|
| `claude` | Maximum quality, cost is not a concern |
| `claude-glm` | Save 85% while maintaining excellent quality |
| `claude-glm-air` | Instant responses for simple tasks |

## 🐛 Troubleshooting

### "command not found"
```bash
source ~/.bashrc  # Reload your shell configuration
```

### "Invalid API key"
Edit `~/.claude/launch-with-glm.sh` and insert your Z.AI key

### Want to change default GLM model
Modify `ANTHROPIC_MODEL` in `~/.claude/launch-with-glm.sh`

## 🤝 Contributing

PRs welcome! Especially for:
- Support for other open models (Llama, Mistral)
- GUI for configuration
- VS Code integration

## 📄 License

MIT - See [LICENSE](LICENSE)

## 🙏 Acknowledgments

- [Zhipu AI](https://z.ai) for GLM-5 and GLM-4.5-Air
- [Anthropic](https://anthropic.com) for Claude Code
- The open source community

## ⭐ Support the Project

If this project saves you money, consider giving it a star ⭐!

---

<p align="center">
  <b>Save. Switch. Code.</b>
</p>