<#
	.SYNOPSIS

	.DESCRIPTION

	.EXAMPLE
#>

Function Import-CachedData {
	[CmdletBinding()]
	Param(
		[Parameter(ValueFromPipeline = $true)]
		$Provider
	)

	Begin {}

	Process {
		Write-Verbose "Retreiving Cache: $($_.Name)"
		$Provider.GetCachedData()
	}

	End {}

}