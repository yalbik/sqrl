Describe "Schema Objects" {
    BeforeAll {
        Function Source-Library
        {
            $LibraryDir = "$($PSScriptRoot)\.."
            $LibraryFiles = Get-ChildItem -Path "$($LibraryDir)\*.ps1" -Recurse | Where-Object { $_.Name -inotmatch '.*Test[s]?\.ps1'}
        
            Write-Host "Sourcing $(([array]$LibraryFiles).Length) files from $($LibraryDir)" -ForegroundColor Blue
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
    
    It "Can create a table" {
        Source-Library

        $TestColumnName = "TestColumn"
        $TestColumnType = "varchar"
        $TestColumnWidth = 32
        $TestTableName = "MyTable"

        $MyColumnType = [ColumnType]::New()
        $MyColumnType.TypeName = $TestColumnType
        $MyColumnType.Width = $TestColumnWidth

        $MyColumn = [Column]::New()
        $MyColumn.Name = $TestColumnName
        $MyColumn.ColumnType = $MyColumnType

        $MyColumns = @($MyColumn)

        $MyTable = [SqlTable]::New()
        $MyTable.Name = $TestTableName
        $MyTable.Columns = $MyColumns

        $MyTable | Should -Not -BeNullOrEmpty
        $MyTable.Name | Should -Be $TestTableName
        $MyTable.Columns | Should -Not -BeNullOrEmpty
        $MyTable.Columns.Length | Should -Be 1
        $MyTable.Columns[0].Name | Should -Be $TestColumnName
        $MyTable.Columns[0].ColumnType.TypeName | Should -Be $TestColumnType
        $MyTable.Columns[0].ColumnType.Width | Should -Be $TestColumnWidth
    }
}
