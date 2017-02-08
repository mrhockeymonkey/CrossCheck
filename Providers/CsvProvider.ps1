<#
	.DESCRIPTION
	A provider to retreive data from csv files
#>

using module ..\Provider.psm1

class CsvProvider : Provider {

	CsvProvider([String]$Name, [String]$Source) : base('CsvProvider', $Name, $Source) {
		#Handled by base class
	}

	#Override method GetData for CliXml 
	[PSObject]GetData() {
		$Data = Import-Csv -Path $this.Source
		Return $Data
	}
}
