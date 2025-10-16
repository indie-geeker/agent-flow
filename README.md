# Claude Code Plugin Marketplace

A curated collection of specialized AI agents for Claude Code, designed to enhance your development workflow with domain-specific expertise.

## 🚀 Quick Start

Install this marketplace in Claude Code:

```bash
/plugin marketplace add https://github.com/indie-geeker/agent-flow.git
```

After installation, restart Claude Code to activate the plugins.

### Reinstalling or Updating

⚠️ **Known Issue**: Due to a Claude Code marketplace caching bug, you must manually clean up before reinstalling.

**Cleanup Script (Recommended)**
```bash
bash scripts/cleanup.sh
```

**Manual Cleanup**
1. Remove marketplace: `/plugin marketplace remove agent-flow`
2. Clean configuration:
   ```bash
   # Backup first
   cp ~/.claude/plugins/known_marketplaces.json ~/.claude/plugins/known_marketplaces.json.backup

   # Remove agent-flow entry from the JSON file
   # You can use jq or edit manually
   ```
3. Restart Claude Code
4. Reinstall with the command above

> **Note**: This is a limitation of Claude Code's plugin system. Marketplace removal doesn't automatically clean up all configuration entries.

## 📦 Available Plugins

### Code Reviewer
**Expert code review specialist for quality, security, and maintainability**

Automatically reviews your code changes with a focus on:
- Code quality and readability
- Security vulnerabilities
- Performance considerations
- Best practices and patterns
- Test coverage

The agent proactively analyzes your git diffs and provides prioritized feedback (critical/warnings/suggestions).

### Flutter Expert
**Cross-platform Flutter application implementation**

Comprehensive Flutter and mobile development expertise:
- Modern architecture patterns (Clean Architecture, MVVM, Bloc)
- State management with Riverpod, Bloc, Provider
- Native platform integrations (iOS/Android)
- Performance optimization
- Offline-first data sync
- App store deployment strategies

Ideal for building production-ready Flutter applications with best practices.

### Content Writer
**Content marketing and SEO optimization specialist**

Creates engaging, SEO-optimized content:
- Blog posts and articles
- Social media content (Twitter/X, LinkedIn)
- Email campaigns
- Meta descriptions and titles
- Content calendars
- Call-to-action optimization

Operates in two modes: **outline** for planning and **write** for creating final content.

## 🔧 Usage

After installation, these agents work automatically based on your natural language requests. Simply describe what you want to do:

### Natural Language Examples

```
Help me review the quality and security of the code
→ Automatically uses agent-flow:code-reviewer

Use flutter expert to develop a project refactoring plan
→ Uses agent-flow:flutter-expert

Write a blog about mobile app development best practices
→ Uses agent-flow:content-writer
```

### Proactive Activation

All agents are configured to activate proactively when relevant tasks are detected:

- **Code Reviewer**: Activates for code quality, security, and architecture discussions
- **Flutter Expert**: Activates for Flutter/mobile development tasks
- **Content Writer**: Activates for content creation and SEO tasks

### Manual Invocation

You can explicitly specify the agent using either its name or full ID:

**Agent name (simple):**
- `flutter-expert`
- `code-reviewer`
- `content-writer`

**Full agent ID (explicit):**
- `agent-flow:flutter-expert`
- `agent-flow:code-reviewer`
- `agent-flow:content-writer`

## 🛠️ Plugin Structure

The unified plugin structure:

```
agent-flow/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
└── agents/
    ├── code-reviewer.md     # Code review agent
    ├── flutter-expert.md    # Flutter expert agent
    └── content-writer.md    # Content writer agent
```

All agents are contained in a single plugin for easier management and simpler agent names.

## 📝 Contributing

Contributions are welcome! To add a new plugin:

1. Fork this repository
2. Create a new plugin directory following the structure above
3. Add your plugin to `.claude-plugin/marketplace.json`
4. Submit a pull request

See [CLAUDE.md](./CLAUDE.md) for detailed plugin development guidelines.

## 📄 License

MIT License - see [LICENSE](./LICENSE) for details.

## 🙋 Support

For issues or questions:
- Open an issue on [GitHub Issues](https://github.com/indie-geeker/agent-flow/issues)
- Refer to [Claude Code documentation](https://docs.claude.com/en/docs/claude-code)

---

**Built for [Claude Code](https://claude.ai/code)** - Anthropic's official CLI for Claude
