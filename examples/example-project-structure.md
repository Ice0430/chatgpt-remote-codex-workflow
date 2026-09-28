# Example Project Structure

```text
ExampleProject/
├─ HANDOFF.md
├─ source/
├─ scripts/
├─ docs/
│  ├─ run-001-review.md
│  └─ run-001-qa.json
├─ logs/
│  └─ run-001.log
├─ output/
│  └─ run-001/
└─ artifacts/
   └─ final-output
```

The exact names do not matter. What matters is that another agent can discover the latest state without reading the Codex GUI.

## Example user message after Codex finishes

```text
Codex finished.
```

The reviewing agent should then inspect the project directly before asking the user to relay screenshots.
