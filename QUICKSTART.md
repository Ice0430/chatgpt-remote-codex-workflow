# Quick Start

## 1. Requirements

On the workstation:
- Node.js 18 or newer
- Codex CLI / Codex app
- Git recommended
- a project folder whose outputs can be inspected later

In ChatGPT:
- Remote Desktop Commander connected and authorized

Check Node.js:

```powershell
node --version
npm --version
npx --version
```
## 2. Start Remote Desktop Commander

On the workstation:

```powershell
npx @wonderwhy-er/desktop-commander@latest remote
```

Complete the browser verification step and keep the terminal process running.

## 3. Verify remote access

Before touching production data, test with a harmless folder:
- list files
- create a small text file
- read it back

## 4. Choose one of three modes

### Mode A — Manual App Mode
ChatGPT writes the instruction. The user pastes it into Codex App.

Best when:
- the user wants a visible Codex conversation
- the task benefits from interactive back-and-forth
- the user wants to manually select the Codex model in the UI
### Mode B — Review-only Remote Mode
After Codex finishes, the user says:

```text
Codex finished.
```

ChatGPT then reads the real project outputs directly through Remote Desktop Commander.

This mode should **not** start another Codex run by itself.

Best when:
- Codex already completed the work
- the goal is to remove screenshot relay
- quota control matters

### Mode C — Auditable Direct CLI Mode
Use only when the user explicitly authorizes ChatGPT to launch Codex directly.

Before starting, ChatGPT must state:
- selected Codex model
- selected reasoning effort
- that the run will consume Codex quota
- that the run may not appear as a normal Codex App conversation
Direct CLI must create an auditable run folder containing at least:

```text
agent-runs/<run-id>/
├─ prompt.md
├─ run-meta.json
├─ trace.jsonl
├─ final.md
├─ stderr.log
├─ git-status.txt
└─ git-diff.patch
```

Never rely on the Codex App's currently selected model. The CLI run must explicitly specify model and reasoning effort.

See [docs/auditable-cli.md](docs/auditable-cli.md).

## 5. Normal daily recommendation

Default to:
1. Manual App Mode for execution.
2. Review-only Remote Mode for inspection.
3. Use Auditable Direct CLI only when convenience is worth the extra automated Codex run.
