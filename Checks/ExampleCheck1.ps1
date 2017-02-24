<#
	.SYNOPSIS
	Check a single data source

	.DESCRIPTION
	This check will import the data cached from .\ExampleData1 and check each service is running. 
	If it is not running then an issue will be raised
#>

Check ExampleCheck1 {
	
	$ServiceStatus = Get-DataProvider -Name 'ServiceStatus' | Import-CachedData

	$ServiceStatus | Where-Object {$_.Status -ne 'Running'} | ForEach-Object {
		Write-Issue -Title "$($_.Service) is not running" -Priority Medium
	}
}
