<#
	.SYNOPSIS

	.DESCRIPTION
#>

Function Invoke-CrossCheck {
	[CmdletBinding()]
	Param(

	)

	#Get all configured data providers and cache the data locally to the filesystem
	Get-DataProvider | Update-CachedData

	#Run each check in sequence 
	Get-ChildItem -Path $PSScriptRoot\..\Checks | ForEach-Object -Process {
		& $_.FullName
	}
}