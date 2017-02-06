using module ..\Provider.psm1

class CsvProvider : Provider {
	[String]$Source
	[String]$Special
	CsvProvider([String]$Name, [String]$Source, [String]$Special) : base('CsvProvider') {
		$this.Name = $Name
		$this.Source =  $Source
		$this.Special = $Special
	}

	[PSObject]GetData() {
		$Data = Import-Csv -Path $this.Source
		Return $Data
	}
}
