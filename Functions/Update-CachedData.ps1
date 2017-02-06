<#
	.SYNOPSIS

	.DESCRIPTION

	.EXAMPLE
#>

Function Update-CachedData {
	[CmdletBinding()]
	Param (
		[Parameter(ValueFromPipeline = $true)]
		$Provider
	)

	Begin {}

	Process {
		Write-Verbose "Caching Data: $($_.Name)"
		$Provider.CacheData()
	}

	End {}
}