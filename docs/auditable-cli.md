# Auditable Direct CLI Mode

This mode lets ChatGPT launch Codex directly through Remote Desktop Commander without sacrificing model control or run history.

Use only after explicit user authorization.

## Required preflight

Before every run, state:
- project / working directory
- selected Codex model
- selected reasoning effort
- expected scope
- that Codex quota will be consumed
- that the run may not appear as a normal Codex App conversation

Do not infer the CLI model from whatever happens to be selected in the Codex desktop UI.
## Codex CLI capabilities used

The current Codex CLI supports:
- --model <MODEL>
- --config <key=value>
- --json for JSONL event output
- --output-last-message <FILE>
- -C / --cd <DIR>

A typical auditable invocation conceptually looks like:

~~~powershell
$prompt | codex exec -C "D:\Projects\ExampleProject" --model "<MODEL>" --config 'model_reasoning_effort="medium"' --json --output-last-message ".\agent-runs\<run-id>\final.md" -
~~~

Capture stdout as trace.jsonl and stderr as stderr.log.
## Recommended wrapper

This repository includes:

~~~text
scripts/run-codex-auditable.ps1
~~~

Example:

~~~powershell
.\scripts\run-codex-auditable.ps1 -ProjectPath "D:\Projects\ExampleProject" -PromptFile "D:\Projects\ExampleProject\next-prompt.md" -Model "<MODEL>" -ReasoningEffort "medium"
~~~

The wrapper creates a timestamped run folder under agent-runs/.

It does not automatically commit changes.
## Why the run folder matters

A CLI run may not show up as a normal visible Codex App conversation.

The run folder becomes the durable audit trail:
- What exact prompt was sent?
- Which model was selected?
- Which reasoning effort was selected?
- What did Codex emit during execution?
- What was its final answer?
- What changed in Git?
- Did the process fail?

This makes CLI execution recoverable months later without depending on a UI thread.
## Continuity after the run

After inspection:
- update HANDOFF.md if the accepted project state changed
- write / update review and QA
- commit an important milestone when appropriate

Do not put every run transcript into AGENTS.md.

## Quota note

Direct CLI is still a Codex execution and may consume Codex quota.

Reviewing files through Remote Desktop Commander alone should not trigger a Codex run. Keep review and execution as separate decisions.
