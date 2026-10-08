$base = "c:\projects\alu-web_react"
$ref = Join-Path $base "_ref_fenan\0x09-react_redux_connectors_and_providers"
$proj = Join-Path $base "react_redux_connectors_and_providers"

0..9 | ForEach-Object {
  $n = $_
  $refDash = Join-Path $ref "task_$n\dashboard"
  $dstDash = Join-Path $proj "task_$n\dashboard"
  if (-not (Test-Path $refDash)) { Write-Warning "Missing $refDash"; return }

  robocopy (Join-Path $refDash "src") (Join-Path $dstDash "src") /E /NFL /NDL /NJH /NJS /nc /ns /np | Out-Null
  if (Test-Path (Join-Path $refDash "dist")) {
    robocopy (Join-Path $refDash "dist") (Join-Path $dstDash "dist") /E /NFL /NDL /NJH /NJS /nc /ns /np | Out-Null
  }
  foreach ($f in @("login-success.json", "notifications.json", "courses.json")) {
    $srcFile = Join-Path $refDash $f
    if (Test-Path $srcFile) {
      Copy-Item $srcFile (Join-Path $dstDash $f) -Force
      if ($f -ne "courses.json") {
        Copy-Item $srcFile (Join-Path $dstDash "dist\$f") -Force -ErrorAction SilentlyContinue
      }
    }
  }
  Write-Host "Synced task_$n"
}

Write-Host "Done."
