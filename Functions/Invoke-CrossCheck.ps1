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

	#Run each check in sequence and convert resulting issues to json data
	$IssueJson = Get-ChildItem -Path $PSScriptRoot\..\Examples\Checks | ForEach-Object -Process {
		& $_.FullName
	} | ConvertTo-Json

	#Write json data to file for the website tom consume
	#Note here using Out-File results in UTF-8-BOM encoding which python does not like
	$Utf8NoBomEncoding = [System.Text.UTF8Encoding]::New($false)
	[System.IO.File]::WriteAllLines("$PSScriptRoot\..\Website\data.json", $IssueJson, $Utf8NoBomEncoding) 
}