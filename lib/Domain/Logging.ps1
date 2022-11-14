Function SqrlLog
{
    param
    (
        [Parameter (Mandatory = $true)]
        $Message,
        [Parameter (Mandatory = $false)]
        $Level = "Info"
    )

    if (!($LogFile))
    {
        throw "$($MyInvocation.MyCommand): `$LogFile is unset!"
    }

    $LogMessage = "[$((get-date).ToString("yyyy/MM/dd HH:mm:ss.ffff"))] [$($Level)] $($Message)"
    Write-Host "$($LogMessage)" -ForegroundColor DarkGray
    Add-Content -Path $LogFile -Value $LogMessage
}

Function Initialize-SqrlLog
{
    if (!($LogFile)) { throw "`$LogFile is unset! Please set it!" }

    if (!(Test-Path -Path $LogDir)) { New-Item -Path $LogDir -ItemType Directory | Out-Null }

    if (Test-Path -Path $LogFile)
    {
        $OldLogDate = (Get-Item -Path $LogFile).CreationTime
        $OldLogDateString = "$($OldLogDate.ToString("yyyyMMddHHmmss"))$((Get-Date).ToString("ffff"))" 

        $OldLogFileName = "$($LogDir)\sqrl_$($OldLogDateString).log"
        Write-Host "Moving old log file to $($OldLogFileName)"
        Move-Item -Path $LogFile -Destination $OldLogFileName | Out-Null
    }

    New-Item -Path $LogFile -ItemType File | Out-Null
    SqrlLog "Initialized new log at $($LogFile)"
}
