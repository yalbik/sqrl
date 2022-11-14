class BaseSqrlObject
{
    [string]$Name
}

class Column : BaseSqrlObject
{
    [ColumnType]$ColumnType
    [int]$Width

    Column() {}
    
    Column(
        [ColumnType]$columnType,
        [int]$width
    ){
        $this.ColumnType = $columnType
        $this.Width = $width
    }
}

class ColumnType : BaseSqrlObject
{
    [string]$TypeName
    [int]$Width

    ColumnType() {}
    
    ColumnType(
        [string]$name,
        [int]$w
    ){
        $this.TypeName = $name
        $this.Width = $w
    }
}

class SqlTable : BaseSqrlObject
{
    [array]$Columns

    SqlTable() {}

    SqlTable(
        [array]$columns
    ){
        $this.Columns = $columns
    }
}
