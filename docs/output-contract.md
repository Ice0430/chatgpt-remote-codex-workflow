# Output Contract

The no-screenshot workflow works reliably only when execution results are written to durable project files.

## Minimum project contract

After each meaningful Codex run, the project should expose:

1. **Final artifact** — code, model, document, dataset, build, etc.
2. **Review report** — what changed, input version, assumptions, unresolved items.
3. **QA result** — machine-readable checks where possible.
4. **Logs** — errors or execution details needed for diagnosis.
5. **Visual/test outputs** — renders, plots, screenshots, diffs, reports.
6. **Next-state marker** — what is done and what must not be assumed.

## Recommended structure

```text
project/
├─ AGENTS.md
├─ HANDOFF.md
├─ docs/
├─ output/
├─ logs/
├─ artifacts/
└─ agent-runs/
```
## Additional contract for Direct CLI

Every auditable CLI run should create:

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

The run folder is the CLI equivalent of a visible conversation history.

Do not use `--ephemeral` for runs that are expected to be auditable unless the user explicitly wants no Codex session persistence and the external run folder is still complete.
## File responsibilities

### AGENTS.md
Stable rules and conventions. Do not use as a chronological run log.

### HANDOFF.md
Current project state, latest accepted artifact, unresolved issues, and the next starting point.

### review / QA
Per-run engineering conclusions and validation.

### agent-runs/
Execution provenance:
- exact prompt
- exact model and effort
- trace
- result
- git context

### Git commits
Important milestones, not every internal thought.
## Human validation

Automated QA proves only what it actually checks.

It may prove:
- a file reopens
- tests pass
- protected objects are unchanged
- expected outputs exist

It does not automatically prove:
- visual similarity
- engineering correctness
- physical plausibility
- factual truth
- customer acceptance

Where human judgment matters, the reviewer should inspect the underlying visual or documentary evidence directly.
