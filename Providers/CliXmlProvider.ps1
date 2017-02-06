<#
	.DESCRIPTION
	
#>

using module ..\Provider.psm1

class CliXmlProvider : Provider {
	[String]$Source
	CliXmlProvider([String]$Name, [String]$Source) : base ('CliXmlProvider') {
		$this.Name = $Name
		$this.Source = $Source
	}

	[PSObject]GetData() {
		$Data = Import-Clixml -Path $this.Source
		Return $Data
	}
}
