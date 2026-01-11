#!/bin/bash
# Install/update idea-tracker skill to Claude Code

SKILL_NAME="idea-tracker"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.claude/skills/$SKILL_NAME"

echo "Installing $SKILL_NAME skill..."
echo "  From: $SOURCE_DIR"
echo "  To:   $TARGET_DIR"

# Remove old installation
rm -rf "$TARGET_DIR"

# Create target directory
mkdir -p "$TARGET_DIR"

# Copy skill files
cp "$SOURCE_DIR/skill/SKILL.md" "$TARGET_DIR/"
cp -r "$SOURCE_DIR/examples" "$TARGET_DIR/"

echo ""
echo "Installed files:"
find "$TARGET_DIR" -type f | sed 's|^|  |'

echo ""
echo "Done. Restart Claude Code to use the updated skill."
