# Architecture

## Three-mode architecture

```text
                         ┌──────────────────────┐
                         │        User          │
                         └──────────┬───────────┘
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │       ChatGPT        │
                         │ plan / review / route│
                         └──────┬────────┬──────┘
                                │        │
               Manual App Mode │        │ Auditable Direct CLI
                                ▼        ▼
                         ┌──────────────────────┐
                         │        Codex         │
                         │   local execution    │
                         └──────────┬───────────┘
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │  Project artifacts   │
                         └──────────┬───────────┘
                                    ▲
                                    │ Review-only Remote
                         ┌──────────┴───────────┐
                         │ Remote Desktop Cmdr  │
                         └──────────────────────┘
```
## Core principle

Remote Desktop Commander is primarily the bridge for **artifact inspection**.

Terminal access makes direct execution possible, but direct execution is an optional mode, not an automatic consequence of having remote access.

## Why three modes

Manual App Mode gives:
- visible Codex conversation
- familiar UI model selection
- easy interactive follow-up

Review-only Remote Mode gives:
- no screenshot relay
- no extra Codex run during review
- direct access to project evidence

Auditable Direct CLI Mode gives:
- hands-off automation
- explicit model / effort control
- machine-readable run history
- reproducible local execution
## Project-agnostic design

The same architecture works for:
- software development
- Python automation
- CAD / STEP generation
- Blender
- spreadsheets
- document production
- data analysis
- research pipelines
- QA / testing
- deployment

Only the project artifacts change.

## Role inversion

ChatGPT is the planner/reviewer by default for efficiency and continuity.

For especially hard tasks, Codex may be asked to plan, critique, or investigate first. That does not change the audit requirement: important conclusions must still be written to durable project files.
