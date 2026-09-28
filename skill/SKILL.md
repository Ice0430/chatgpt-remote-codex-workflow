# Skill: ChatGPT Remote Codex Workflow

Use this skill when a user plans work with ChatGPT, executes with Codex on a workstation, and wants ChatGPT to review real results without manually relaying screenshots or copied Codex messages.

This skill is project-agnostic.

## Core principle

Remote access does **not** automatically authorize a new Codex run.

Separate:
- planning
- execution
- review

The default post-run behavior is **Review-only Remote Mode**.
## Roles

### ChatGPT
- planner, reviewer, orchestrator by default
- selects Codex model and reasoning effort before execution
- writes the execution instruction
- reviews real project artifacts
- may launch Direct CLI only when explicitly authorized

### Codex
- local executor by default
- may also act as planner when explicitly delegated
- must leave durable project outputs

### User
- owns goals and approvals
- chooses execution mode
- performs final human judgment where needed
## Modes

### A. Manual App Mode
The user pastes the ChatGPT-generated instruction into Codex App.

Use when:
- visible conversation history is useful
- interactive back-and-forth is expected
- the user wants manual UI control

### B. Review-only Remote Mode
Use after the user says Codex has finished.

Actions:
1. Do not start Codex.
2. Connect to the authorized workstation.
3. Locate latest project outputs.
4. Read HANDOFF / review / QA / logs / git state.
5. Inspect visual or test artifacts.
6. Compare against requirements.
7. Return pass / refine / blocked / user judgment.
8. If another run is needed, state model + effort and provide the next prompt.
9. Stop unless the user explicitly authorizes Direct CLI.
### C. Auditable Direct CLI Mode
Use only when the user explicitly authorizes ChatGPT to execute Codex through CLI.

Before launch:
1. state the chosen Codex model
2. state the reasoning effort
3. state that Codex quota will be consumed
4. state that the run may not appear as a normal Codex App conversation
5. create a unique run-id / run directory

Never inherit model choice implicitly from the Codex App UI.

Every CLI invocation must explicitly pass the model and reasoning effort.
## Direct CLI audit contract

Capture at minimum:

```text
agent-runs/<run-id>/
├─ prompt.md
├─ run-meta.json
├─ trace.jsonl
├─ final.md
├─ stderr.log
├─ git-status-before.txt
├─ git-status-after.txt
├─ git-diff.patch
└─ summary.md
```

Use Codex CLI structured output when available:
- `--json` for JSONL events
- `--output-last-message` for final response
- explicit `--model`
- explicit config override for reasoning effort

Do not use an invisible/unlogged CLI run as the normal path.
## Project continuity rules

Prefer:
- AGENTS.md for stable agent rules
- HANDOFF.md for current state
- per-run review and QA for validation
- agent-runs/ for CLI provenance
- Git commits for accepted milestones

Do not turn AGENTS.md into a chronological transcript.

After a successful Direct CLI run, update HANDOFF/review files when the new state matters for future work.
## Screenshot fallback

Ask the user for a screenshot only when required information exists only in a GUI and cannot reasonably be recovered from:
- project files
- logs
- terminal/process output
- generated artifacts
- structured CLI trace

## Quota discipline

Review-only Remote Mode must not consume additional Codex quota by launching another Codex run.

Direct CLI may consume Codex quota. Avoid redundant rereads or unnecessary extra runs. Prefer reviewing existing artifacts first.

## Scope

Applicable to:
- software
- CAD / STEP
- Blender
- data analysis
- documents
- automation
- research tooling
- QA / testing
- deployment
- other local-agent work
