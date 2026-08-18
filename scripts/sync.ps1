[CmdletBinding()]
param(
  [ValidateSet('check', 'sync')]
  [string]$Mode = 'check',
  [string]$Registry,
  [switch]$Bootstrap
)

$ErrorActionPreference = 'Stop'
$repositoryRoot = Split-Path -Parent $PSScriptRoot
$sourcePath = Join-Path $repositoryRoot 'docs\filosofia-desarrollo-software.md'
if (-not $Registry) {
  $Registry = Join-Path $repositoryRoot 'consumers.local.json'
}

if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
  throw "No existe la fuente canonica: $sourcePath"
}
if (-not (Test-Path -LiteralPath $Registry -PathType Leaf)) {
  throw "No existe el registro de consumidores: $Registry"
}

function Get-Sha256([string]$Path) {
  return (Get-FileHash -Algorithm SHA256 -LiteralPath $Path).Hash.ToLowerInvariant()
}

$sourceContent = Get-Content -Raw -Encoding UTF8 -LiteralPath $sourcePath
$versionMatch = [regex]::Match($sourceContent, '(?m)^Versi.n: `([^`]+)`\.\r?$')
if (-not $versionMatch.Success) {
  throw 'La fuente canonica no declara una version reconocible.'
}
$version = $versionMatch.Groups[1].Value
$sourceHash = Get-Sha256 $sourcePath
$registryData = Get-Content -Raw -Encoding UTF8 -LiteralPath $Registry | ConvertFrom-Json
if (-not $registryData.consumers -or $registryData.consumers.Count -eq 0) {
  throw 'El registro no contiene consumidores.'
}

$evaluations = foreach ($consumer in $registryData.consumers) {
  if (-not (Test-Path -LiteralPath $consumer.path -PathType Container)) {
    [pscustomobject]@{
      Name = $consumer.name
      Root = $consumer.path
      Target = $null
      Lock = $null
      CurrentHash = $null
      LockedHash = $null
      Status = 'missing_project'
    }
    continue
  }

  $targetPath = Join-Path $consumer.path 'docs\filosofia-desarrollo-software.md'
  $lockPath = Join-Path $consumer.path 'docs\filosofia-desarrollo-software.lock.json'
  $currentHash = if (Test-Path -LiteralPath $targetPath -PathType Leaf) {
    Get-Sha256 $targetPath
  } else {
    $null
  }
  $lockedHash = $null
  if (Test-Path -LiteralPath $lockPath -PathType Leaf) {
    $lockData = Get-Content -Raw -Encoding UTF8 -LiteralPath $lockPath | ConvertFrom-Json
    $lockedHash = [string]$lockData.sha256
  }

  $status = if (-not $currentHash) {
    'missing_snapshot'
  } elseif ($currentHash -eq $sourceHash) {
    'current'
  } elseif ($lockedHash -and $currentHash -ne $lockedHash) {
    'local_changes'
  } elseif (-not $lockedHash -and -not $Bootstrap) {
    'untracked_snapshot'
  } else {
    'outdated'
  }

  [pscustomobject]@{
    Name = $consumer.name
    Root = $consumer.path
    Target = $targetPath
    Lock = $lockPath
    CurrentHash = $currentHash
    LockedHash = $lockedHash
    Status = $status
  }
}

foreach ($evaluation in $evaluations) {
  Write-Output ("[{0}] {1}" -f $evaluation.Status, $evaluation.Name)
}

if ($Mode -eq 'check') {
  $invalid = $evaluations | Where-Object {
    $_.Status -ne 'current' -or -not (Test-Path -LiteralPath $_.Lock -PathType Leaf)
  }
  if ($invalid) {
    throw 'Hay consumidores sin sincronizar o sin lock verificable.'
  }
  Write-Output ("Todos los consumidores usan la version {0} ({1})." -f $version, $sourceHash)
  return
}

$conflicts = $evaluations | Where-Object {
  $_.Status -in @('missing_project', 'local_changes', 'untracked_snapshot')
}
if ($conflicts) {
  throw 'La sincronizacion se cancelo antes de escribir porque existen rutas ausentes o divergencias locales.'
}

foreach ($evaluation in $evaluations) {
  $docsDirectory = Split-Path -Parent $evaluation.Target
  if (-not (Test-Path -LiteralPath $docsDirectory -PathType Container)) {
    New-Item -ItemType Directory -Path $docsDirectory | Out-Null
  }
  if ($evaluation.CurrentHash -ne $sourceHash) {
    Copy-Item -LiteralPath $sourcePath -Destination $evaluation.Target
  }

  $lock = [ordered]@{
    source = 'https://github.com/joacogcarrillo/software-development-philosophy'
    document = 'docs/filosofia-desarrollo-software.md'
    version = $version
    sha256 = $sourceHash
    syncedAt = (Get-Date).ToUniversalTime().ToString('o')
  }
  $lock | ConvertTo-Json | Set-Content -Encoding UTF8 -LiteralPath $evaluation.Lock
  Write-Output ("[synced] {0}" -f $evaluation.Name)
}

Write-Output ("Sincronizacion completa: version {0} ({1})." -f $version, $sourceHash)
