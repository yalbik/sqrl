Describe "Logging Objects" {
    BeforeAll {
        Function Source-Library
        {
            $LibraryDir = "$($PSScriptRoot)\.."
            $LibraryFiles = Get-ChildItem -Path "$($LibraryDir)\*.ps1" -Recurse | Where-Object { $_.Name -inotmatch '.*Test[s]?\.ps1'}
        
            Write-Host "Sourcing $(([array]$LibraryFiles).Length) files from $($LibraryDir)..." -ForegroundColor Blue
            try
            {
                foreach ($file in $LibraryFiles)
                {
                    Write-Host "`tSourcing $($file)" -ForegroundColor Blue
                }
            }
            catch
            {
                Write-Host "Error sourcing $($file):" -ForegroundColor Red
                Write-Host "$($_)" -ForegroundColor Red
                throw $_
            }
        }
    }

    It "Creates a log" {
        $LogFile = "TestDrive:\sqrl.log"
        
        Source-Library

        Bootstrap-Sqrl

        $LogFile | Should -Exist
    }
}