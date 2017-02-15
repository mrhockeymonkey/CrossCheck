#Add script level variables
New-Variable -Name ModuleRoot -Value $PSScriptRoot -Scope script

#Add alias'
New-Alias -Name Check -Value Invoke-Check -Force

#Define Enums
Enum Priority {
	High
	Medium
	Low
}

<#
	.SYNOPSIS
	Abstract Class: Provider

	.DESCRIPTION
	This abstract class provides the basis from which providers should inherit. One cannot instantiate this
	class directly. Provider plugins should implement every define method. Providers are responsible for 
	retreiving datafrom external sources, caching that data for local use
#>
class Provider {
	[String]$Provider
	[String]$Name
	[String]$Source

	Provider([String]$Provider, [String]$Name, [String]$Source) {
		#Throw if trying to instantiate this class
		$Type = $this.GetType()
		If ($Type -eq [Provider]){ #is
			throw "$Type is an abstract class and must be inherited"
		}
		$this.Provider = $Provider
		$this.Name     = $Name
		$this.Source   = $Source
	}

	[PSObject]GetData() {
		throw "Method GetData not implemented for provider $($this.ProviderName)"
	}

	[Void]CacheData() {
		$this.GetData() | Export-Clixml -Path "$PSScriptRoot\Cache\$($this.Name).xml" -Force
	}

	[PSObject]GetCachedData() {
		$CachedData = Import-Clixml -Path "$PSScriptRoot\Cache\$($this.Name).xml"
		return $CachedData
	}
}

<#
	.SYNOPSIS
	Standard Class: Issue

	.DESCRIPTION
	An issue is the object raised as the result of a check. 
#>
class Issue {
	[String]$Title
	[Priority]$Priority
	[String]$Message

	Issue([String]$Title, [Priority]$Priority) {
		$this.Title = $Title
		$this.Priority = $Priority
	}
}


#Load Providers
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
