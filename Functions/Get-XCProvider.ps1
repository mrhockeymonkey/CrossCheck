<#

#>

#using module ..\CrossCheck.psm1
#using module ..\Providers\clixml.psm1
#using module ..\Providers\csv.psm1

Function Get-XCProvider {
	[CmdletBinding()]
	Param (
	)

	[CliXmlProvider]::New()
	[CsvProvider]::New()
}