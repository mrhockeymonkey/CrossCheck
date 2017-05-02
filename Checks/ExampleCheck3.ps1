<#
	.SYNOPSIS
	Cross refences multiple data sources that do not have a direct link

	.DESCRIPTION
	This check pulls two data sets that do directly relate to each other and uses its own logic
	to determine links between them, In this case it is inferred that serviceX will be on serverX,
	serviceY will be on serverY, and so on. 

#>

$Help = "@
To resolve this issue first check and resolve the state of the server. 

If the server is fully operational there may be an issue with the service. 
Try to start theservice and check the logs for errors. 
@"

Check ExampleCheck3 Medium {
	$BrokenServers = Get-DataProvider -Name 'ServerState' | Import-CachedData | Where-Object {$_.State -ne 'OK'}
	$BrokenServices = Get-DataProvider -Name 'ServiceStatus' | Import-CachedData | Where-Object {$_.Status -ne 'Running'}

	$ServicesDownDueToServerState = $BrokenServers.Hostname -replace '^server(\d+)','Service$1'

	$ServicesDownDueToServerState | ForEach-Object {
		If($_ -in $BrokenServices.Service) {
			Write-Output "$_ is down due to issues with its hosting server"
		}
	}
}