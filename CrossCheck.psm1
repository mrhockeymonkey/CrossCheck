#Load classes
using module .\Issue.psm1
using module .\Provider.psm1

#Load plugin providers
Try {
	Get-ChildItem "$PSScriptRoot\Providers\*.ps1" | ForEach-Object {
		. $_.FullName
	}
}
Catch {
	Write-Warning "Could not load provider: $($_.Exception.Message)"
	Continue
}

#Load Functions
Try {
	Get-ChildItem "$PSScriptRoot\Functions\*.ps1" | ForEach-Object {
		. $_.FullName
	}
}
Catch {
	Write-Warning "Could not load function: $($_.Exception.Message)"
	Continue
}

#Add alias'
New-Alias -Name Check -Value Invoke-Check -Force
