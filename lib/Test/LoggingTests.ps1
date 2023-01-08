Describe "Logging Objects" {
    It "Creates a log" {
        $LogFile = "TestDrive:\sqrl.log"
        
        Bootstrap-Sqrl -LogFile $LogFile

        $LogFile | Should -Exist
    }
}