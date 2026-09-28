# ChatGPT Remote Codex Workflow

A project-agnostic workflow for using ChatGPT as planner/reviewer, Codex as executor, and Remote Desktop Commander as the bridge between them.

The core goal is to remove manual screenshot/message relay **without losing auditability, model control, or long-term project continuity**.

This workflow supports three modes:

1. **Manual App Mode** — ChatGPT writes the instruction; the user pastes it into the Codex app.
2. **Review-only Remote Mode** — after Codex finishes, ChatGPT reads the resulting files directly through Remote Desktop Commander.
3. **Auditable Direct CLI Mode** — when explicitly authorized, ChatGPT may launch Codex CLI directly, but only with an explicit model/effort and a persistent run record.

This is not a Blender-specific workflow. It applies to coding, CAD, data, documents, research tooling, automation, QA, deployment, and other local-agent projects.
## Recommended default loop

```text
Discuss with ChatGPT
        ↓
ChatGPT chooses Codex model + reasoning effort
        ↓
ChatGPT writes the execution instruction
        ↓
User pastes into Codex App
        ↓
Codex executes and writes project artifacts
        ↓
User says: "Codex finished."
        ↓
ChatGPT reads artifacts remotely
        ↓
Pass / refine / blocked / user judgment
        ↓
Next instruction
```

The important change is only the review handoff: instead of the user copying screenshots back to ChatGPT, ChatGPT reads the workstation directly.
## Optional direct execution

If the user explicitly authorizes direct execution, ChatGPT may use Codex CLI through Remote Desktop Commander.

Direct CLI must be **auditable**:
- model is explicitly specified for every run
- reasoning effort is explicitly specified for every run
- prompt is saved
- JSONL event trace is saved
- final Codex message is saved
- stderr is saved
- git status / diff / commit context is saved
- the run receives a stable run directory / id

Do not silently start a Codex CLI run merely because remote terminal access is available.

See [docs/auditable-cli.md](docs/auditable-cli.md).
## Roles

### ChatGPT
- planner, reviewer, and orchestrator by default
- chooses the appropriate Codex model and reasoning effort
- converts discussion into execution instructions
- reviews actual outputs and evidence
- may launch Direct CLI only when that mode is explicitly authorized

### Codex
- local executor by default
- edits files, runs tools, drives MCPs, builds artifacts
- may also perform deep planning when explicitly delegated
- must leave durable results instead of relying only on chat text

### Remote Desktop Commander
- bridges the AI client to an authorized workstation
- provides filesystem, terminal, process, and inspection tools
- removes the need for screenshot relay
### User
- owns goals and approvals
- chooses whether a run happens in App Mode or Direct CLI Mode
- performs final human judgment where required

## Recommended project contract

```text
project/
├─ HANDOFF.md
├─ docs/
│  ├─ latest-review.md
│  └─ latest-qa.json
├─ output/
├─ logs/
├─ artifacts/
└─ agent-runs/
   └─ <run-id>/
      ├─ prompt.md
      ├─ run-meta.json
      ├─ trace.jsonl
      ├─ final.md
      ├─ stderr.log
      ├─ git-status.txt
      └─ git-diff.patch
```

A Codex chat response is not the only project record. Anything needed for future continuation should be written to the project or captured in an auditable run folder.
## Long-term continuity

Use different files for different kinds of memory:

- **AGENTS.md** — stable agent rules and project conventions
- **HANDOFF.md** — current project state and next starting point
- **review / QA files** — per-run engineering judgment and validation
- **agent-runs/** — exact CLI execution history
- **Git commits** — durable project milestones

This keeps the project understandable even when an execution happened outside the Codex desktop UI.

## Documentation

- [QUICKSTART.md](QUICKSTART.md)
- [docs/architecture.md](docs/architecture.md)
- [docs/codex-workflow.md](docs/codex-workflow.md)
- [docs/auditable-cli.md](docs/auditable-cli.md)
- [docs/output-contract.md](docs/output-contract.md)
- [SECURITY.md](SECURITY.md)
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- [skill/SKILL.md](skill/SKILL.md)
