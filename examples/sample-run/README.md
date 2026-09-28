# Sanitized Example Run

This example is fictional and contains no private project data.

Scenario: ChatGPT and the user agree to update a small project README. The user explicitly authorizes **Auditable Direct CLI Mode**.

The example demonstrates what should remain after the run so a future reviewer can answer:
- what prompt was sent?
- which model / reasoning effort was requested?
- what did Codex report?
- what changed in Git?
## Example structure

```text
sample-run/
└─ agent-runs/
   └─ 20260101-120000/
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

The trace is intentionally short and illustrative. Real Codex JSONL event shapes can vary by CLI version.
