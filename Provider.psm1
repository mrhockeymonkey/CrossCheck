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