# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**claude-idea-tracker** is a Claude Code skill for capturing project-related ideas and maintaining session continuity. It consists of:

- `skill/SKILL.md` - The skill definition that Claude reads and follows
- `examples/` - Reference templates for IDEAS.md and SESSION.md

This is NOT a code project - it's documentation/configuration that extends Claude Code's capabilities.

## Repository Structure

```
skill/
  SKILL.md          # The actual skill (Claude reads this)
examples/
  IDEAS-example.md  # Reference template for idea tracking
  SESSION-example.md # Reference template for session state
```

## Development Guidelines

### Skill File (SKILL.md)

The skill file uses YAML frontmatter:
```yaml
---
name: idea-tracker
description: When to trigger this skill (shown in Claude's skill list)
---
```

Key constraints:
- **ASCII-only for diagrams** - No Unicode box-drawing characters (GitHub rendering issues)
- **IDs are immutable** - The ID system (F001, T001, etc.) is a core principle
- **English section names** - SESSION.md uses "Today", "Next", "History"

### Testing Changes

Since this is a skill (not code), test by:
1. Install locally: `xcopy /E /I skill C:\Users\<you>\.claude\skills\idea-tracker`
2. Start a new Claude Code session
3. Trigger the skill by discussing project ideas or session continuity

### Versioning

Follow [Keep a Changelog](https://keepachangelog.com/) format in CHANGELOG.md. This is a v1.0.0 release - maintain backwards compatibility with the ID system.

## Git Workflow

```bash
# Commit messages in English (per user preference)
git commit -m "Add feature X to skill workflow"
```

## Key Design Decisions

1. **Minimal complexity** - This skill intentionally does one thing well
2. **Flexible templates** - Examples are starting points, not rigid schemas
3. **Project-scoped** - Not a generic note-taking system
4. **History preservation** - Ideas move to Completed/Superseded/Rejected, never deleted
