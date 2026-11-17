# Automated Flutter Agent Kit Validation Script (PowerShell)
# Verifies file integrity, skill manifests, YAML frontmatter, and directory structures.

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$rootDir = (Get-Item "$scriptDir\..\..").FullName

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  Flutter Agent Kit Automated Validation Suite    " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "Root Directory: $rootDir"

$failures = 0
$filesChecked = 0

function Assert-FileExists {
    param([string]$path, [string]$description)
    $fullPath = Join-Path $rootDir $path
    $script:filesChecked++
    if (-not (Test-Path $fullPath)) {
        Write-Host " [FAIL] Missing file: $path ($description)" -ForegroundColor Red
        $script:failures++
    } else {
        $item = Get-Item $fullPath
        if ($item.Length -lt 10) {
            Write-Host " [FAIL] File is empty or truncated (<10 bytes): $path" -ForegroundColor Red
            $script:failures++
        } else {
            Write-Host " [PASS] $path ($($item.Length) bytes)" -ForegroundColor Green
        }
    }
}

Write-Host "`n--- 1. Checking Root Entry Points & Agent Compatibility ---" -ForegroundColor Yellow
Assert-FileExists "README.md" "Root Documentation"
Assert-FileExists "CHANGELOG.md" "Changelog"
Assert-FileExists "CONTRIBUTING.md" "Contribution Guidelines"
Assert-FileExists "LICENSE" "License"
Assert-FileExists "SECURITY.md" "Security Policy"
Assert-FileExists "TASKS.md" "Implementation Tracker"
Assert-FileExists "AGENTS.md" "Universal Agent Entry Point"
Assert-FileExists "CLAUDE.md" "Claude Code Entry Point"
Assert-FileExists "GEMINI.md" "Gemini CLI Entry Point"
Assert-FileExists ".cursorrules" "Cursor Legacy Config"
Assert-FileExists ".github\copilot-instructions.md" "GitHub Copilot Instructions"

Write-Host "`n--- 2. Checking Core Engineering System ---" -ForegroundColor Yellow
$coreFiles = @(
    "core\agent-principles.md",
    "core\engineering-standards.md",
    "core\project-understanding.md",
    "core\context-management.md",
    "core\token-efficiency.md",
    "core\change-discipline.md",
    "core\verification-policy.md"
)
foreach ($file in $coreFiles) {
    Assert-FileExists $file "Core Engineering Policy"
}

Write-Host "`n--- 3. Checking Documentation Suite ---" -ForegroundColor Yellow
$docFiles = @(
    "docs\REFERENCE_AUDIT.md",
    "docs\AGENT_KIT_AUDIT.md",
    "docs\EXTERNAL_RESEARCH.md",
    "docs\REAL_DATA_INTEGRITY.md",
    "docs\DESIGN_SYSTEM_STANDARDS.md",
    "docs\NAVIGATION_AND_ICON_STANDARDS.md",
    "docs\PERFORMANCE_ENGINEERING_STANDARDS.md",
    "docs\ARCHITECTURE.md",
    "docs\GETTING_STARTED.md",
    "docs\SKILLS_CATALOG.md",
    "docs\WORKFLOWS.md",
    "docs\MCP_GUIDE.md",
    "docs\AGENT_COMPATIBILITY.md",
    "docs\WINDOWS_DEVELOPMENT.md",
    "docs\FAQ.md"
)
foreach ($file in $docFiles) {
    Assert-FileExists $file "Documentation"
}

Write-Host "`n--- 4. Checking Skills Manifests & YAML Frontmatter (34 Skills) ---" -ForegroundColor Yellow
$skillsDir = Join-Path $rootDir "skills"
$skills = Get-ChildItem -Path $skillsDir -Directory
Write-Host "Found $($skills.Count) skills in $skillsDir"

if ($skills.Count -lt 34) {
    Write-Host " [FAIL] Expected at least 34 skills, but found $($skills.Count)" -ForegroundColor Red
    $script:failures++
}

foreach ($skill in $skills) {
    $manifest = Join-Path $skill.FullName "SKILL.md"
    $script:filesChecked++
    if (-not (Test-Path $manifest)) {
        Write-Host " [FAIL] Skill missing SKILL.md: $($skill.Name)" -ForegroundColor Red
        $script:failures++
        continue
    }
    
    $content = Get-Content -Path $manifest -Raw
    if ($content.Length -lt 50) {
        Write-Host " [FAIL] Skill manifest too small: $($skill.Name)/SKILL.md" -ForegroundColor Red
        $script:failures++
        continue
    }

    # Verify YAML frontmatter
    if ($content -notmatch "(?s)^---\s*\r?\nname:\s*[\w\-]+\s*\r?\ndescription:.+?\r?\n---") {
        Write-Host " [FAIL] Invalid or missing YAML frontmatter in: $($skill.Name)/SKILL.md" -ForegroundColor Red
        $script:failures++
    } else {
        Write-Host " [PASS] Skill: $($skill.Name)" -ForegroundColor Green
    }
}

Write-Host "`n--- 5. Checking Lifecycle Workflows (24 Workflows) ---" -ForegroundColor Yellow
$workflowsDir = Join-Path $rootDir "workflows"
$workflows = Get-ChildItem -Path $workflowsDir -Directory
Write-Host "Found $($workflows.Count) workflows in $workflowsDir"

if ($workflows.Count -lt 24) {
    Write-Host " [FAIL] Expected at least 24 workflows, but found $($workflows.Count)" -ForegroundColor Red
    $script:failures++
}

foreach ($wf in $workflows) {
    $wfFile = Join-Path $wf.FullName "WORKFLOW.md"
    Assert-FileExists "workflows\$($wf.Name)\WORKFLOW.md" "Workflow definition"
}

Write-Host "`n--- 6. Checking Templates & Prompts ---" -ForegroundColor Yellow
$templates = @(
    "templates\PRD.md",
    "templates\ARCHITECTURE.md",
    "templates\DESIGN.md",
    "templates\DATABASE.md",
    "templates\API.md",
    "templates\TASKS.md",
    "templates\TEST_PLAN.md",
    "templates\SECURITY.md",
    "templates\DECISIONS.md",
    "templates\MEMORY.md",
    "templates\.env.example"
)
foreach ($t in $templates) {
    Assert-FileExists $t "Project Template"
}

Write-Host "`n==================================================" -ForegroundColor Cyan
Write-Host "  Validation Summary: $filesChecked Files Checked " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

if ($failures -gt 0) {
    Write-Host "Validation FAILED with $failures issue(s)." -ForegroundColor Red
    exit 1
} else {
    Write-Host "All validation checks PASSED successfully! (0 failures)" -ForegroundColor Green
    exit 0
}
