---
name: idea-tracker
description: Use when ideas worth preserving emerge from conversation, or when session continuity is needed across conversations. Captures ideas for later evaluation and maintains handoff state between sessions.
---

# Idea & Session Tracker

## Overview

Lightweight system for capturing **project-related ideas** and maintaining session continuity across Claude conversations. Two files per project: **IDEAS.md** (idea backlog) and **SESSION.md** (handoff state).

This is NOT a generic note-taking system. Ideas tracked here should be relevant to the project at hand.

## Trigger Patterns

### Explicit triggers (always activate):

| User says | Action |
|-----------|--------|
| "IDEA:", "Idea:" | Capture the idea to IDEAS.md |
| "Save this idea", "Remember this for later" | Capture to IDEAS.md |
| "Add to backlog", "Track this" | Capture to IDEAS.md |
| "What did we work on?", "Where were we?" | Read SESSION.md |
| "Update session", "Save progress" | Update SESSION.md |

### Implicit triggers (activate if files exist):

| Situation | Action |
|-----------|--------|
| First message of session + `docs/SESSION.md` exists | Read SESSION.md (limit: 80 lines) |
| User says "let's stop here", "that's enough for today" | Offer to update SESSION.md |
| Significant idea emerges from discussion | Ask: "Should I add this to IDEAS.md?" |

### Don't activate when:

- Project has no `docs/` folder (too simple)
- Conversation is one-off troubleshooting
- Idea is generic/unrelated to current project

## Session Start

**When:** First message of a new session, IF `docs/SESSION.md` exists.

**Action:**
```
Read docs/SESSION.md limit: 80
```

This reads "Today" and "Next" sections. Briefly summarize context to user:
> "Last session you worked on X. Next priorities were Y and Z."

**Skip if:** File doesn't exist, or user explicitly says "fresh start" / "ignore previous session".

## File Locations

```
project/
  docs/
    IDEAS.md      # Project idea backlog
    SESSION.md    # Handoff state
```

## Workflow

```
+-----------------+
|  Session start  |
+--------+--------+
         |
         v
+-----------------------------+
| SESSION.md exists?          |
+-----------------------------+
         |
    yes  |   no
         |    +---> Skip, proceed normally
         v
+-----------------------------+
| Read SESSION.md (limit: 80) |
| Summarize to user           |
+-----------------------------+
         |
         v
+-----------------+
|  Work on tasks  |<-----------------+
+--------+--------+                  |
         |                           |
         v                           |
    +---------+    no                |
    |  Idea?  |----------------------+
    +----+----+                      |
         | yes                       |
         v                           |
+---------------------+              |
|  Project-related?   |              |
+---------------------+              |
         |                           |
    yes  |   no                      |
         |    +--> Parking Lot       |
         v          (temp section)   |
+-----------------+                  |
| Add to IDEAS.md |------------------+
+-----------------+
         |
         v (session end)
+---------------------+
| Update SESSION.md   |
+---------------------+
```

## Integration with Other Skills

### vs TodoWrite (Claude's built-in task tracking)

| TodoWrite | IDEAS.md |
|-----------|----------|
| Tasks for THIS session | Ideas for THE FUTURE |
| "Fix bug, run tests, commit" | "We could add dark mode someday" |
| Disappears when session ends | Persists in repository |
| Operational/tactical | Strategic/backlog |

**Rule:** If it should be done TODAY, use TodoWrite. If it's for LATER, use IDEAS.md.

### vs brainstorming skill

When brainstorming generates multiple ideas:
1. User picks one to implement now
2. Other promising ideas → IDEAS.md (ask first)
3. Rejected ideas → don't save

### vs writing-plans skill

When writing implementation plans:
1. Some ideas don't fit the current plan
2. Good ideas excluded from plan → IDEAS.md
3. Reference: "See also F003 in IDEAS.md"

## Capturing Ideas

When a project-related idea emerges:

1. **Assign ID** by category prefix:
   - Common: F=Feature, U=UX, T=Technical, B=Business
   - Add categories as needed (e.g., S=Security, P=Performance)
   - **IDs are immutable:** Once assigned, never changes

2. **Record source:**
   - U = User (explicit request)
   - D = Discussion (emerged from conversation)
   - C = Claude (suggested) → **ask user confirmation before adding!**

3. **Evaluate:**
   - Effort: S (hours) / M (days) / L (weeks)
   - Value: L / M / H

4. **Add to appropriate table** in IDEAS.md

## Good vs Bad Usage

### Good Usage

```
User: "IDEA: we could add export to PDF"
Claude: Added to IDEAS.md as F004 - Export to PDF

User: "That's interesting but not for now"
Claude: Should I save this to IDEAS.md for later? (Effort: M, Value: H)

User: "Where were we last time?"
Claude: [Reads SESSION.md] Last session you completed the login flow.
        Next priorities were: API error handling, unit tests.
```

### Bad Usage - Don't Do This

| Bad | Why | Instead |
|-----|-----|---------|
| Save every small observation | IDEAS.md becomes noise | Only save actionable ideas |
| Use IDEAS.md as todo list | That's what TodoWrite is for | IDEAS.md = backlog, TodoWrite = today |
| Add ideas without asking | User might not want it saved | Always confirm for Claude-suggested ideas |
| Create IDEAS.md for trivial projects | Overhead not worth it | Skip for one-off scripts |
| Save ideas unrelated to project | Pollutes project backlog | Use Parking Lot temporarily |

## Parking Lot

For ideas that emerge but are NOT related to current project:
- Add to "## Parking Lot" section at bottom of IDEAS.md
- Minimal info: just the idea and date
- User moves/deletes them manually later
- Temporary holding area, not permanent home

## Idea Lifecycle

| Event | Action |
|-------|--------|
| **Implemented** | Move to "## Completed" with date |
| **Superseded** | Move to "## Superseded", note replacement |
| **Rejected** | Move to "## Rejected" with reason |

Keep original ID when moving. Never delete - history matters.

## Session End

Update SESSION.md:
1. Move "Today" content to "History" section (bottom)
2. Write new "Today" with completed items
3. Update "Next" based on current state

## Effort/Value Calibration

| Project Factor | Effort Impact |
|----------------|---------------|
| Solo dev | S=hours, M=1-2 days, L=week |
| Team | S=1 day, M=sprint, L=multiple sprints |
| Greenfield | Lower effort (no legacy) |
| Legacy | Higher effort (integration) |

## Quick Reference

| Action | Command |
|--------|---------|
| Read session context | `Read docs/SESSION.md limit: 80` |
| Search idea by ID | `Grep "F001" docs/IDEAS.md` |
| Full session history | `Read docs/SESSION.md` (no limit) |

## Examples

The `examples/` folder contains reference templates:
- `IDEAS-example.md` - Example structure for IDEAS.md
- `SESSION-example.md` - Example structure for SESSION.md

These are **starting points, not rigid templates**. Adapt to your project:
- Rename/add/remove category tables
- Add project-specific fields
- Change date format or remove dates

Requirements:
- Keep IDs immutable once assigned
- Maintain Completed/Superseded/Rejected sections
- SESSION.md needs "Today", "Next", and "History" sections

## First-Time Setup

For new projects, create `docs/IDEAS.md` and `docs/SESSION.md` using examples as reference. Customize as needed.
