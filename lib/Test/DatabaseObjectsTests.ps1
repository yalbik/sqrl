Describe "Schema Objects" {
    It "Can create a table" {
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
