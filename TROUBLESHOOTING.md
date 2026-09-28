# Troubleshooting

## Codex quota changed but I cannot see a new conversation in Codex App

Likely cause: the work was executed through Codex CLI rather than the desktop chat UI.

CLI execution can consume Codex quota without creating a normal visible App conversation.

Use Auditable Direct CLI Mode so each run leaves:
- prompt.md
- run-meta.json
- trace.jsonl
- final.md
- stderr.log
- git status / diff

Do not rely on the App conversation list as the only execution history.
## ChatGPT reviewed the project and unexpectedly launched Codex again

Review-only Remote Mode should not start a new Codex run.

Expected behavior after "Codex finished":
1. read existing artifacts
2. inspect QA / logs / output
3. decide pass or refinement
4. provide the next prompt
5. stop

A new CLI run requires explicit user authorization.
## CLI used the wrong model

Do not rely on the model currently selected in Codex App.

For Direct CLI:
- pass --model explicitly
- pass reasoning effort explicitly through --config
- save both values in run-meta.json

If model choice matters, treat a missing explicit model as a workflow error.
## Remote Desktop Commander device is offline

Common causes:
- the remote agent terminal was closed
- the machine slept or shut down
- network connectivity changed
- authorization expired

Restart the Remote Desktop Commander remote process on the workstation and confirm the device is online before continuing.
## Should agent-runs be committed to Git?

Not always.

Commit:
- durable handoff state
- accepted review/QA
- important milestone artifacts

Keep raw traces local when they contain:
- secrets
- private paths
- customer data
- noisy execution detail

If publishing a trace, sanitize it first.
