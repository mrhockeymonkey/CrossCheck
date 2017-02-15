<#
	.DESCRIPTION
	A provider to retreive data from clixml files
#>

class CliXmlProvider : Provider {

	CliXmlProvider([String]$Name, [String]$Source) : base ('CliXmlProvider', $Name, $Source) {
		#Handled by base class
	}

	#Override method GetData for CliXml 
	[PSObject]GetData() {
		$Data = Import-Clixml -Path $this.Source
		Return $Data
	}
}
