<#
	.DESCRIPTION
	The base class for all data providers. 
	All plugin providers should inherit this class and override methods appropriatly
#>



<#
	.SYNOPSIS
	Abstract Class: Provider

	.DESCRIPTION
	This abstract class provides the basis from which providers should inherit. One cannot instantiate this
	class directly. Provider plugins should implement every define method. Providers are responsible for 
	retreiving datafrom external sources, caching that data for local use
#>
class Provider {
	[String]$Name
	[String]$Provider

	Provider([String]$Provider) {
		#Throw if trying to instantiate this class
		$Type = $this.GetType()
		If ($Type -eq [Provider]){ #is
			throw "$Type is an abstract class and must be inherited"
		}

		$this.Provider = $Provider
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

#>
class Source {
	[String]$Name
	[String]$Provider
}

class Check {
	[String]$CheckName
	[String[]]$ProviderList
	[ScriptBlock]$Script

	Check([String]$CheckName, [String[]]$ProviderName,[ScriptBlock]$Script) {
		$this.CheckName = $CheckName
		$this.ProviderList = $ProviderName
		$this.Script = $Script
	}

	[Issue[]]Invoke() {
		Write-Verbose "hahahh"
		return $this.Script.Invoke() 
		
	}
}

class Issue {
	[String]$Title
	[Priority]$Priority
	[String]$Message
	#[PSObject[]]$Detail

	Issue([String]$Title, [Priority]$Priority) {
		$this.Title = $Title
		$this.Priority = $Priority
	}
}