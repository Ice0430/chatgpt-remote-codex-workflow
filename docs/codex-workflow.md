# Codex Workflow

## Before every execution

ChatGPT must first state:
- recommended Codex model
- recommended reasoning / thinking effort
- why that level fits the task

Then choose an execution mode:

1. Manual App Mode
2. Review-only Remote Mode
3. Auditable Direct CLI Mode

Review-only Remote Mode is not an execution mode by itself; it is the normal post-run inspection path.
## Manual App Mode

ChatGPT provides the prompt. The user pastes it into Codex App.

The execution prompt should define:
- goal
- authoritative sources
- allowed scope
- prohibited scope
- expected outputs
- stop condition
- conflict escalation rule

After Codex finishes, the user only needs to say:

```text
Codex finished.
```

ChatGPT then switches to Review-only Remote Mode.
## Review-only Remote Mode

When reviewing a completed run:

1. Do not start a new Codex run automatically.
2. Connect through Remote Desktop Commander.
3. Read the project state, review, QA, logs, outputs, git diff, and final artifact.
4. Compare against the original requirements.
5. Classify:
   - pass
   - refinement needed
   - blocked / conflict
   - user judgment required
6. If another execution is needed, produce the next prompt and stop.

The user decides whether that next execution will be pasted into Codex App or authorized as Direct CLI.
## Auditable Direct CLI Mode

Use only after explicit user authorization.

Before launching:
- state that Codex quota will be consumed
- state that the run may not appear as a normal Codex App conversation
- explicitly choose model
- explicitly choose reasoning effort

Never assume the Codex App's currently selected model applies to CLI.

Every direct CLI run must capture:
- prompt
- model / effort
- start/end time
- project path
- git HEAD / branch
- JSONL event trace
- final Codex response
- stderr
- pre/post git status
- diff or equivalent change summary
## During execution

Codex may optimize implementation details unless the user has locked:
- facts
- dimensions
- counts
- spatial / logical relationships
- safety boundaries
- protected files or no-change areas

If an alternative would change a locked fact, Codex should stop and report the conflict instead of silently rewriting the requirement.

## Screenshot fallback

Ask the user for a screenshot only when the required information exists only in a GUI and cannot reasonably be recovered from:
- project files
- logs
- terminal output
- process output
- generated artifacts
