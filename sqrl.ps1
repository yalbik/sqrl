Clear-Host
Write-Host "$(get-date) $($MyInvocation.MyCommand): sqrl is starting..."

# Init a log
$LogDir = "$($PSScriptRoot)\log"
$LogFile = "$($LogDir)\sqrl.log"

$LibDir = "$($PSScriptRoot)\lib"
Write-Host "Getting library from $($LibDir)..."
$LibFiles = Get-ChildItem -Path "$($LibDir)\*.ps1" -Recurse | Where-Object { $_.Name -inotmatch '.*Test[s]?\.ps1'}
Write-Host "Sourcing $(([array]$LibFiles).Length) library files..."

$LibFiles | ForEach-Object { 
    $LibFile = $_
    Write-Host "`tSourcing $($LibFile)... " -NoNewline
    try
    {
        . $LibFile
    }
    catch
    {
        Write-Host "FAIL!" -ForegroundColor Red
        throw "Couldn't source $($LibFile): $($_)"
    }
    Write-Host "Success!" -ForegroundColor DarkGreen
}

Bootstrap-Sqrl -LogFile $LogFile

SqrlLog "$($MyInvocation.MyCommand) is initialized!"

$MyColumnType = [ColumnType]::New()
$MyColumnType.TypeName = "varchar"
$MyColumnType.Width = 32

$MyColumn = [Column]::New()
$MyColumn.Name = "TestColumn"
$MyColumn.ColumnType = $MyColumnType

$MyColumns = @($MyColumn)

$MyTable = [SqlTable]::New()
$MyTable.Name = "MyTable"
$MyTable.Columns = $MyColumns

Write-Host

