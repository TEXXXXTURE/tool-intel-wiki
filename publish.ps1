# publish.ps1 - build VitePress and push to gh-pages (GitHub Pages deploy)
# Usage: pwsh -File publish.ps1   (run after content updates; executed daily by the pipeline)
# NOTE: keep this file ASCII-only so it parses under any system codepage.
$ErrorActionPreference = 'Continue'
Set-Location $PSScriptRoot

function Run-Checked([string]$Label, [scriptblock]$Block) {
    Write-Host "[$Label]"
    & $Block 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { Write-Error "$Label failed (exit $LASTEXITCODE)"; exit 1 }
}

Run-Checked '1/3 build site' { npm run docs:build }
$dist = Join-Path $PSScriptRoot 'docs\.vitepress\dist'
if (-not (Test-Path (Join-Path $dist 'index.html'))) { Write-Error 'build output missing index.html'; exit 1 }

$tmp = Join-Path $env:TEMP 'tool-intel-ghpages'
git worktree remove $tmp --force 2>&1 | Out-Null
if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue }

git fetch origin gh-pages 2>&1 | Out-Null
if (git rev-parse --verify --quiet origin/gh-pages) {
    Run-Checked '2/3 attach gh-pages worktree' { git worktree add $tmp gh-pages }
} else {
    Run-Checked '2/3 create gh-pages worktree' { git worktree add --detach $tmp }
    git -C $tmp checkout --orphan gh-pages 2>&1 | Out-Null
    git -C $tmp rm -rf . 2>&1 | Out-Null
}

Write-Host '[3/3 copy dist + commit + push]'
Get-ChildItem $tmp -Force | Where-Object { $_.Name -ne '.git' } | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
Copy-Item (Join-Path $dist '*') -Destination $tmp -Recurse -Force

git -C $tmp add -A 2>&1 | Out-Null
if (git -C $tmp diff --cached --quiet) {
    Write-Host 'no changes, skip push.'
} else {
    git -C $tmp commit -m "deploy: $(Get-Date -Format 'yyyy-MM-dd HH:mm')" 2>&1 | Out-Null
    git -C $tmp push origin gh-pages 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { Write-Error 'push gh-pages failed'; git worktree remove $tmp --force 2>&1 | Out-Null; exit 1 }
    Write-Host 'deployed to gh-pages'
}
git worktree remove $tmp --force 2>&1 | Out-Null
