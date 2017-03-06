<#

#>

Function Invoke-Check {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true, Position = 0)]
		[String]$Name,

		[Parameter(Mandatory = $true, Position = 1)]
		[ValidateSet('High','Medium','Low')]
		[Priority]$Priority,

		[Parameter(Mandatory = $true, Position = 2)]
		[ScriptBlock]$Script
	)
	Write-Verbose "Invoking Check: $Name"

	Invoke-Command -ScriptBlock $Script | ForEach-Object {
		Write-Issue -Title $Name -Priority $Priority -Message $_
	}
}