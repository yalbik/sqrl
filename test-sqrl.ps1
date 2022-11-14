$TestsDir = "$($PSScriptRoot)\lib\Test"
$Tests = Get-ChildItem -Path "$($TestsDir)\*Test*.ps1"

Write-Host "Running $(([array]$Tests).Length) tests from $($TestsDir)"

$Tests | Foreach-Object { Invoke-Pester $_ }
