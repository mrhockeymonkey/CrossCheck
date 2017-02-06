<#

#>

Function Invoke-Check {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true, Position = 0)]
		[String]$Name,

		[Parameter(Mandatory = $true, Position = 1)]
		[ScriptBlock]$Script
	)

	$Script.Invoke()
}