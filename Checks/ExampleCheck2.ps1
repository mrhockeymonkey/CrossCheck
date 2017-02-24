<#
	.SYNOPSIS
	Cross reference multiple data sources

	.DESCRIPTION
	This check will import data from ExampleData1 & Exampledata2 in order to cross them.
	It will check to see if there are an services not running that are of type public and raise
	an issues if present
#>

Check ExampleCheck2 {
	
	$BrokenServices = Get-DataProvider -Name 'ServiceStatus' | Import-CachedData | Where-Object {$_.Status -ne 'Running'}
	$PublicServices = Get-DataProvider -Name 'ServiceTypes' | Import-CachedData | Where-Object {$_.Type -eq 'Public'}

	$PublicServices | Where-Object {$_.Service -in $BrokenServices.Service} | ForEach-Object {
		Write-Issue -Title "Public service $($_.Service) is broken" -Priority High
	}
}
