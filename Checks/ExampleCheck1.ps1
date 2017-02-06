<#
	.DESCRIPTION
	
#>

Check isCodeRunning {
	
	$ProcessData = Get-DataProvider -Name 'Process1' | Import-CachedData

	$Processdata | Where-Object {$_.ProcessName -match 'code'} | ForEach-Object {
		Write-Issue -Title 'Code is currently running' -Priority Medium
	}
}
