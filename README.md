# claude-idea-tracker

A lightweight [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skill for capturing **project-related ideas** and maintaining session continuity across conversations.

## What it does

- **Captures ideas** that emerge during development conversations
- **Maintains session state** for seamless handoff between Claude sessions
- **Tracks idea lifecycle** from inception to completion/rejection
- **Stays focused** on the current project (not a generic note-taking system)

## Why use this?

When working with Claude Code on a project, valuable ideas often emerge mid-conversation. Without a system, they get lost. This skill:

- Triggers automatically when ideas worth preserving emerge
- Asks for confirmation before adding Claude-suggested ideas
- Keeps ideas organized with effort/value evaluation
- Preserves session context so you can resume work seamlessly

## Installation

### Option 1: User-level (all projects)

Copy the `skill/` folder to your Claude skills directory:

```bash
# Windows
copy skill C:\Users\<you>\.claude\skills\idea-tracker

# macOS/Linux
cp -r skill ~/.claude/skills/idea-tracker
```

### Option 2: Project-level (single project)

Copy the `skill/` folder to your project:

```bash
cp -r skill your-project/.claude/skills/idea-tracker
```

## Usage

Once installed, Claude will automatically:

1. **On session start**: Read `docs/SESSION.md` to restore context (if it exists)
2. **During work**: Capture project-related ideas to `docs/IDEAS.md` (explicit triggers like "IDEA:" or when you confirm)
3. **On session end**: Update `docs/SESSION.md` with completed work and next steps

### First-time setup for a project

Create `docs/IDEAS.md` and `docs/SESSION.md` in your project. Use the files in `examples/` as a starting point, then customize for your project's needs.

### Manual triggers

You can also explicitly ask Claude to:
- "Save this idea for later"
- "Add this to the backlog"
- "Update the session state"
- "What did we work on last time?"

## File Structure

```
your-project/
├── docs/
│   ├── IDEAS.md      # Idea backlog (features, UX, technical, business)
│   └── SESSION.md    # Session handoff state
└── ...
```

## Idea Categories

Default categories (customize per project):

| Prefix | Category |
|--------|----------|
| F | Feature |
| U | UX |
| T | Technical |
| B | Business |

Add more as needed (S=Security, P=Performance, etc.)

## Idea Sources

| Code | Meaning |
|------|---------|
| U | User (explicitly requested) |
| D | Discussion (emerged from conversation) |
| C | Claude (suggested and confirmed by user) |

## Effort/Value Matrix

| Code | Effort | Value |
|------|--------|-------|
| S | Hours | Low |
| M | Days | Medium |
| L | Weeks | High |

Calibrate based on your project context (solo dev vs team, greenfield vs legacy).

## Examples

See the `examples/` folder for reference templates:
- [`IDEAS-example.md`](examples/IDEAS-example.md)
- [`SESSION-example.md`](examples/SESSION-example.md)

## Key Principles

1. **IDs are immutable** - Once assigned (e.g., F001), never changes
2. **History is preserved** - Ideas move to Completed/Superseded/Rejected, never deleted
3. **Project-focused** - Off-topic ideas go to Parking Lot temporarily
4. **Flexible structure** - Adapt categories and columns to your needs

## License

MIT License - see [LICENSE](LICENSE)

## Contributing

Issues and PRs welcome! This skill is intentionally minimal. Complexity should be avoided.

## Author

Simone Callegari ([@SimoneCallegari](https://github.com/SimoneCallegari))
