# Security

Remote Desktop Commander can expose powerful local filesystem and terminal capabilities. Treat the connected AI account and paired workstation as privileged access.

## Recommended defaults

- Start with a dedicated test directory.
- Use allowed-directory restrictions where practical.
- Keep API keys, tokens, SSH keys, browser profiles, password stores, and customer data out of public examples.
- Require explicit user approval before destructive actions.
- Keep important projects under version control or backup.
## Direct CLI risk

Auditable Direct CLI Mode can consume Codex quota and execute real local changes.

Before a Direct CLI run:
- obtain explicit user authorization for that run or clearly scoped sequence
- state the selected model and reasoning effort
- state that quota will be consumed
- state that the execution may not appear as a normal Codex App conversation
- create a persistent run directory

Do not silently launch `codex exec`, `codex resume`, or equivalent merely because remote terminal access exists.
## Broad filesystem access

Broad filesystem access is convenient for users who frequently switch projects, but it increases blast radius.

If broad access is enabled:
- keep the workstation account least-privileged where possible
- use MFA on connected AI and GitHub accounts
- avoid plaintext secrets in ordinary project files
- review destructive commands carefully

## Never publish

Do not commit:
- OAuth pairing codes
- device IDs or auth tokens
- personal workstation names if identifying
- private usernames or home-directory paths
- API keys or GitHub tokens
- customer files
- proprietary screenshots
- private CAD / Blender models
- internal logs containing secrets
## Audit logs can contain sensitive data

`trace.jsonl`, stderr, prompts, and git diffs may contain:
- file paths
- source code
- customer names
- internal identifiers
- environment details

Before publishing an example run:
1. redact secrets and private identifiers
2. replace real paths with placeholders
3. remove proprietary artifacts
4. verify the diff does not contain credentials

Use placeholders such as:
- `WORKSTATION-01`
- `D:\Projects\ExampleProject`
- `<YOUR_GITHUB_USERNAME>`
