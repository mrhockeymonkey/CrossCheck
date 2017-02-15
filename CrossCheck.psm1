#Load classes
using module .\Issue.psm1
using module .\Provider.psm1

#Add script level variables
New-Variable -Name ModuleRoot -Value $PSScriptRoot -Scope script

#Add alias'
New-Alias -Name Check -Value Invoke-Check -Force

#Load plugin providers
Try {
	Get-ChildItem "$PSScriptRoot\Providers\*.ps1" | ForEach-Object {
		$Item = $_
		Write-Debug "Loading Function: $($Item.BaseName)"
		# Dot-sourcing in this way is faster as it skips validation of a ps1 file
		. ([scriptblock]::Create([io.file]::ReadAllText($Item.FullName)))
	}
}
Catch {
	Write-Warning "Could not load $($Item.Name): $($_.Exception.Message)"
	Continue
}

#Load Functions
Try {
	Get-ChildItem "$PSScriptRoot\Functions\*.ps1" | ForEach-Object {
		$Item = $_
		Write-Debug "Loading Function: $($Item.BaseName)"
		# Dot-sourcing in this way is faster as it skips validation of a ps1 file
		. ([scriptblock]::Create([io.file]::ReadAllText($Item.FullName)))
	}
}
Catch {
	Write-Warning "Could not load $($Item.Name): $($_.Exception.Message)"
	Continue
}
