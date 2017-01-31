<#
	.DESCRIPTION
	The base class for all data providers. 
	All plugin providers should inherit this class and override methods appropriatly
#>
class Provider {
	[String]$ProviderName
}

