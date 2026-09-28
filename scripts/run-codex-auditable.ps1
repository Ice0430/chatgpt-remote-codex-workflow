param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,

    [Parameter(Mandatory = $true)]
    [string]$PromptFile,

    [Parameter(Mandatory = $true)]
    [string]$Model,

    [Parameter(Mandatory = $true)]
    [ValidateSet("low","medium","high","xhigh")]
    [string]$ReasoningEffort,

    [string]$RunRoot = ""
)

$ErrorActionPreference = "Stop"
$started = Get-Date
$runId = $started.ToString("yyyyMMdd-HHmmss")
if (-not (Test-Path $ProjectPath)) {
    throw "ProjectPath not found: $ProjectPath"
}
if (-not (Test-Path $PromptFile)) {
    throw "PromptFile not found: $PromptFile"
}

if ([string]::IsNullOrWhiteSpace($RunRoot)) {
    $RunRoot = Join-Path $ProjectPath "agent-runs"
}

$runDir = Join-Path $RunRoot $runId
New-Item -ItemType Directory -Force -Path $runDir | Out-Null

$promptCopy = Join-Path $runDir "prompt.md"
$tracePath = Join-Path $runDir "trace.jsonl"
$finalPath = Join-Path $runDir "final.md"
$stderrPath = Join-Path $runDir "stderr.log"
Copy-Item -LiteralPath $PromptFile -Destination $promptCopy -Force
$isGit = $false
try {
    $inside = (& git -C $ProjectPath rev-parse --is-inside-work-tree 2>$null)
    $isGit = ($inside -eq "true")
} catch {}

$branch = ""
$headBefore = ""
if ($isGit) {
    $branch = (& git -C $ProjectPath branch --show-current)
    $headBefore = (& git -C $ProjectPath rev-parse HEAD)
    (& git -C $ProjectPath status --short) | Set-Content -Encoding UTF8 (Join-Path $runDir "git-status-before.txt")
} else {
    "Not a Git repository." | Set-Content -Encoding UTF8 (Join-Path $runDir "git-status-before.txt")
}

$codexVersion = (& codex --version)
$prompt = Get-Content -Raw -Encoding UTF8 $PromptFile
$effortOverride = 'model_reasoning_effort="' + $ReasoningEffort + '"'
$arguments = @(
    "exec",
    "-C", $ProjectPath,
    "--model", $Model,
    "--config", $effortOverride,
    "--json",
    "--output-last-message", $finalPath,
    "-"
)

$prompt | & codex @arguments 1> $tracePath 2> $stderrPath
$exitCode = $LASTEXITCODE
$finished = Get-Date

$headAfter = ""
if ($isGit) {
    $headAfter = (& git -C $ProjectPath rev-parse HEAD)
    (& git -C $ProjectPath status --short) | Set-Content -Encoding UTF8 (Join-Path $runDir "git-status-after.txt")
    (& git -C $ProjectPath diff --binary) | Set-Content -Encoding UTF8 (Join-Path $runDir "git-diff.patch")
} else {
    "Not a Git repository." | Set-Content -Encoding UTF8 (Join-Path $runDir "git-status-after.txt")
    "" | Set-Content -Encoding UTF8 (Join-Path $runDir "git-diff.patch")
}
$meta = [ordered]@{
    run_id = $runId
    started_at = $started.ToString("o")
    finished_at = $finished.ToString("o")
    project_path = $ProjectPath
    prompt_file = $promptCopy
    model = $Model
    reasoning_effort = $ReasoningEffort
    codex_version = $codexVersion
    exit_code = $exitCode
    mode = "auditable-direct-cli"
    git = [ordered]@{
        branch = $branch
        head_before = $headBefore
        head_after = $headAfter
    }
}

$meta | ConvertTo-Json -Depth 4 | Set-Content -Encoding UTF8 (Join-Path $runDir "run-meta.json")
$summary = @"
# Codex CLI Run

- Run ID: $runId
- Project: $ProjectPath
- Model: $Model
- Reasoning effort: $ReasoningEffort
- Exit code: $exitCode
- Started: $($started.ToString("o"))
- Finished: $($finished.ToString("o"))
- Git branch: $branch
- HEAD before: $headBefore
- HEAD after: $headAfter

## Files
- prompt.md
- run-meta.json
- trace.jsonl
- final.md
- stderr.log
- git-status-before.txt
- git-status-after.txt
- git-diff.patch
"@

$summary | Set-Content -Encoding UTF8 (Join-Path $runDir "summary.md")
Write-Output $runDir
exit $exitCode
