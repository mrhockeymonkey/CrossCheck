#Load Providers
Try {
	Get-ChildItem $PSScriptRoot\Providers | ForEach-Object {
		$ProviderName = $_.Name
		Write-Debug "Loading Provider: $ProviderName"
		. $_.FullName
	}
}
Catch {
	Write-Warning "Could not load $($ProviderName): $($_.Exception.Message)"
	Continue
}

#Load Functions
Try {
	Get-ChildItem $PSScriptRoot\Functions | ForEach-Object {
		$FunctionName = $_.Name
		Write-Debug "Loading Function: $FunctionName"
		. $_.FullName
	}
}
Catch {
	Write-Warning "Could not load $($FunctionName): $($_.Exception.Message)"
	Continue
}

#Add alias for check
New-Alias -Name Check -Value Invoke-Check