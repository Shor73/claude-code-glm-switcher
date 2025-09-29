# Claude Code - GLM Switcher 🚀

> Seamlessly switch between GLM-4.5 (Z.AI) and Claude models in Claude Code - Save 85% on AI costs while maintaining frontier-level performance

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GLM-4.5](https://img.shields.io/badge/GLM--4.5-Supported-green.svg)](https://z.ai)
[![Claude](https://img.shields.io/badge/Claude-Compatible-blue.svg)](https://claude.ai)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

## 🎯 What is Claude Code - GLM Switcher?

Claude Code - GLM Switcher is a powerful bash script that allows developers to seamlessly switch between **GLM-4.5** (China's most advanced open AI model) and **Claude's native models** within Claude Code environment. 

### Why Use Claude Code - GLM Switcher?

- **💰 85% Cost Reduction**: Use GLM-4.5 at $3/month instead of Claude at $20-200/month
- **🚀 Frontier Performance**: GLM-4.5 ranks 3rd globally in comprehensive benchmarks
- **🔄 Seamless Switching**: Change models with a single command
- **🛡️ No Vendor Lock-in**: Use open models or proprietary ones as needed
- **⚡ Zero Setup Time**: Get running in under 2 minutes

## 📊 Cost Comparison

| Plan | Claude Pro | Claude Max | GLM-4.5 | Savings |
|------|------------|------------|---------|---------|
| Monthly | $20 | $200 | $3 | 85-98% |
| Annual | $240 | $2,400 | $36 | $204-2,364 |
| API (per 1M tokens) | $15-75 | $15-75 | $0.60-2.20 | 90%+ |

## 🎬 Quick Start

### Prerequisites

- Unix-based system (Linux, macOS, or WSL2 on Windows)
- Node.js v20.0+
- Claude Code installed (`npm install -g @claude/code`)

### Installation

```bash
# 1. Clone this repository
git clone https://github.com/yourusername/claude-code-glm-switcher.git
cd claude-code-glm-switcher

# 2. Make the script executable
chmod +x claude-code-glm-switcher.sh

# 3. Run the installer
./install.sh

# 4. Start the switcher
claude-glm
```

## 🔧 Manual Installation

If you prefer to set up manually:

```bash
# 1. Create the claude config directory
mkdir -p ~/.claude

# 2. Copy the switcher script
cp claude-code-glm-switcher.sh ~/.claude/
chmod +x ~/.claude/claude-code-glm-switcher.sh

# 3. Add alias to your shell config
echo "alias claude-glm='~/.claude/claude-code-glm-switcher.sh'" >> ~/.bashrc
source ~/.bashrc

# 4. Get your Z.AI API key
# Visit https://z.ai and create a free account
# Generate an API key from the dashboard

# 5. Run the switcher
claude-glm
```

## 📖 Usage

### Interactive Mode

Simply run:
```bash
claude-glm
```

You'll see a menu like this:
```
╔══════════════════════════════════════════╗
║    Claude Code - GLM Switcher v2.0       ║
╚══════════════════════════════════════════╝

GLM-4.5 Models (Z.AI):
  1) GLM-4.5 (Full - Best for complex tasks)
  2) GLM-4.5-Air (Fast - Best for quick tasks)

Claude Models (Anthropic):
  3) Claude Opus 4.1 (Most capable)
  4) Claude Sonnet 4.0 (Balanced)

Select an option [0-4]:
```

### Quick Switch Commands

For faster switching, use these aliases:

```bash
# Switch to GLM-4.5
use-glm

# Switch to Claude native
use-claude

# Check current configuration
claude-status
```

## 🎨 Features

- **🔄 Seamless Model Switching**: Change between GLM and Claude models instantly
- **💾 Automatic Backups**: Configuration automatically backed up before changes
- **📊 Usage Statistics**: Track your model usage over time
- **🔐 Secure API Key Storage**: Keys stored securely with proper permissions
- **🎯 Smart Mode Detection**: Automatically selects thinking vs fast mode based on task
- **📝 Detailed Logging**: All actions logged for troubleshooting
- **🚀 Environment Management**: Handles all environment variables automatically

## ⚙️ Configuration

Claude Code - GLM Switcher creates/modifies these files:

- `~/.claude/settings.json` - Main configuration file
- `~/.env` - Environment variables
- `~/.claude/glm_api_key` - Secure API key storage
- `~/.claude/backups/` - Configuration backups
- `~/.claude/switcher.log` - Activity log

### Example Configuration

```json
{
  "apiBaseUrl": "https://api.z.ai/api/anthropic",
  "apiTimeout": 3000000,
  "model": "glm-4.5",
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
```

## 🤖 About GLM-4.5

GLM-4.5 is a state-of-the-art language model developed by Zhipu AI (Z.ai):

- **355B total parameters** (32B active via MoE)
- **Ranks #3 globally** across 12 comprehensive benchmarks
- **90.6% tool-calling success rate**
- **128K token context window**
- **Open-weight under MIT license**

### Benchmark Performance

| Benchmark | GLM-4.5 | Claude 3.5 | GPT-4 |
|-----------|---------|------------|-------|
| MMLU-Pro | 84.6% | 86.2% | 85.8% |
| Coding (SWE-bench) | 64.2% | 62.1% | 65.3% |
| Tool Use (BFCL) | 90.6% | 89.5% | 91.2% |

## 🛠️ Advanced Usage

### Custom Workflows

Create automated workflows combining both models:

```bash
# Use GLM for analysis, Claude for refinement
./scripts/hybrid-workflow.sh

# Batch processing with automatic model selection
./scripts/batch-process.sh /path/to/files
```

### API Integration

Use the configuration in your own tools:

```python
import json
import os

# Load current configuration
with open(os.path.expanduser("~/.claude/settings.json")) as f:
    config = json.load(f)

# Use appropriate endpoint
api_url = config["apiBaseUrl"]
model = config["model"]
```

## 📚 Documentation

- [Full Documentation](./docs/README.md)
- [API Reference](./docs/API.md)
- [Troubleshooting Guide](./docs/TROUBLESHOOTING.md)
- [Contributing Guidelines](./CONTRIBUTING.md)

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Setup

```bash
# Fork and clone the repository
git clone https://github.com/yourusername/claude-code-glm-switcher.git

# Create a feature branch
git checkout -b feature/amazing-feature

# Make your changes and test
./test.sh

# Commit and push
git commit -m "Add amazing feature"
git push origin feature/amazing-feature

# Open a Pull Request
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Zhipu AI](https://z.ai) for creating GLM-4.5
- [Anthropic](https://anthropic.com) for Claude Code
- The open-source community for continuous feedback and improvements

## 💬 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/claude-code-glm-switcher/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/claude-code-glm-switcher/discussions)
- **Email**: your-email@example.com

## 🚀 What's Next?

- [ ] GUI version for non-technical users
- [ ] Support for more open models (Llama, Mistral, etc.)
- [ ] Docker container for easy deployment
- [ ] VS Code extension
- [ ] Performance analytics dashboard
- [ ] Automatic model selection based on task type

## ⭐ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=yourusername/claude-code-glm-switcher&type=Date)](https://star-history.com/#yourusername/claude-code-glm-switcher&Date)

---

<p align="center">
  Made with ❤️ by developers, for developers
</p>

<p align="center">
  If this project saves you money, consider starring ⭐ the repository!
</p>
