#!/bin/bash

# Claude Code Marketplace Cleanup Script
# This script removes the agent-flow marketplace from your Claude Code configuration

set -e

CLAUDE_CONFIG_DIR="$HOME/.claude/plugins"
CLAUDE_SETTINGS="$HOME/.claude/settings.json"
MARKETPLACE_NAME="agent-flow"

echo "🧹 Cleaning up agent-flow marketplace..."

# Check if config directory exists
if [ ! -d "$CLAUDE_CONFIG_DIR" ]; then
    echo "❌ Claude Code plugins directory not found at $CLAUDE_CONFIG_DIR"
    exit 1
fi

# Remove marketplace entry from known_marketplaces.json
KNOWN_MARKETPLACES="$CLAUDE_CONFIG_DIR/known_marketplaces.json"
if [ -f "$KNOWN_MARKETPLACES" ]; then
    echo "📝 Removing marketplace entry from known_marketplaces.json..."

    # Create backup
    cp "$KNOWN_MARKETPLACES" "$KNOWN_MARKETPLACES.backup"

    # Remove the marketplace entry using jq if available, otherwise use sed
    if command -v jq &> /dev/null; then
        jq "del(.\"$MARKETPLACE_NAME\")" "$KNOWN_MARKETPLACES" > "$KNOWN_MARKETPLACES.tmp"
        mv "$KNOWN_MARKETPLACES.tmp" "$KNOWN_MARKETPLACES"
        echo "✅ Marketplace entry removed using jq"
    else
        # Fallback: manual JSON manipulation (less reliable)
        echo "⚠️  jq not found. Please manually edit $KNOWN_MARKETPLACES"
        echo "   Remove the \"$MARKETPLACE_NAME\" entry from the JSON file"
    fi
fi

# Remove marketplace directory if it exists
MARKETPLACE_DIR="$CLAUDE_CONFIG_DIR/marketplaces/$MARKETPLACE_NAME"
if [ -d "$MARKETPLACE_DIR" ]; then
    echo "🗑️  Removing marketplace directory..."
    rm -rf "$MARKETPLACE_DIR"
    echo "✅ Marketplace directory removed"
fi

# Remove plugin entries from settings.json
if [ -f "$CLAUDE_SETTINGS" ]; then
    echo "📝 Removing plugin entries from settings.json..."

    # Create backup
    cp "$CLAUDE_SETTINGS" "$CLAUDE_SETTINGS.backup"

    # Remove plugin entries matching *@agent-flow pattern
    if command -v jq &> /dev/null; then
        # Use jq to remove all keys matching the pattern in enabledPlugins
        jq '
            if .enabledPlugins then
                .enabledPlugins |= with_entries(
                    select(.key | test("@'"$MARKETPLACE_NAME"'$") | not)
                )
            else
                .
            end
        ' "$CLAUDE_SETTINGS" > "$CLAUDE_SETTINGS.tmp"
        mv "$CLAUDE_SETTINGS.tmp" "$CLAUDE_SETTINGS"
        echo "✅ Plugin entries removed from settings.json"
    else
        echo "⚠️  jq not found. Please manually edit $CLAUDE_SETTINGS"
        echo "   Remove entries ending with @$MARKETPLACE_NAME from enabledPlugins"
    fi
else
    echo "ℹ️  settings.json not found, skipping..."
fi

echo ""
echo "✨ Cleanup complete!"
echo ""
echo "Next steps:"
echo "1. Restart Claude Code"
echo "2. Run: /plugin marketplace add https://github.com/indie-geeker/agent-flow.git"
echo "   Or:  /plugin marketplace add /path/to/agent-flow"
