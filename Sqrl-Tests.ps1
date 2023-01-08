
$TestsDir = "$($PSScriptRoot)\lib\Test"
$Tests = Get-ChildItem -Path "$($TestsDir)\*Test*.ps1"

$PesterConfiguration = [PesterConfiguration]::Default
$PesterConfiguration.Run.Path = $Tests
$PesterConfiguration.Run.PassThru = $true

$LogDir = "$($PSScriptRoot)\TestLogs"
$LogFile = "$($LogDir)\sqrl-test.log"

$LibraryDir = "$($PSScriptRoot)\.."
$LibraryFiles = Get-ChildItem -Path "$($LibraryDir)\*.ps1" -Recurse | Where-Object { ($_.Name -inotmatch '.*Test[s]?\.ps1') -and ($_.Name -inotmatch 'sqrl.ps1')}

Write-Host "Sourcing $(([array]$LibraryFiles).Length) files from $($LibraryDir)..." -ForegroundColor Blue
try
{
    foreach ($file in $LibraryFiles)
    {
        Write-Host "`tSourcing $($file)" -ForegroundColor Blue
        . $file
    }
}
catch
{
    Write-Host "Error sourcing $($file):" -ForegroundColor Red
    Write-Host "$($_)" -ForegroundColor Red
    throw $_
}

Write-Host "Running $(([array]$Tests).Length) tests from $($TestsDir)"

Write-Host "Invoking Pester" 
Invoke-Pester -Configuration $PesterConfiguration

Remove-Item -Path $LogDir -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
