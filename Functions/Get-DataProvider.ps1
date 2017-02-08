<#
	.SYNOPSIS

	.DESCRIPTION

	.EXAMPLE
	
#>

Function Get-DataProvider {
	[CmdletBinding()]
	Param (
		[String]$Name, 
		
		[String]$ConfigDocument = "$PSScriptRoot\..\ProviderConfig.json"
	)

	#Read configuration file
	$Path = Resolve-Path $ConfigDocument
	Write-Verbose "Reading: $Path"
	$ProviderConfig = Get-Content -Path $Path -Raw -ErrorAction Stop | ConvertFrom-Json 
	
	#Filter unwanted providers is user specifies name
	If ($PSBoundParameters.ContainsKey('Name')) {
		$ProviderConfig = $ProviderConfig | Where-Object {$_.Config.Name -like $PSBoundParameters['Name']}
	}

	#Loop through config and instatiate the required provider class for each
	$ProviderConfig | ForEach-Object {
		$ThisProvider = $_.Provider

		#A defined provider may have 1 or more configs nested underneath, so loop through
		$_.Config | ForEach-Object {
			
			#Get the values of each config property
			#Note definitions must respect the correct order of arguments for this to work
			$Arguments = $_.psobject.properties.value
			
			#Some Debug
			Write-Debug "TypeName: $ThisProvider"
			Write-Debug "Arguments: $($Arguments -join ' ,')"
			
			#Instantiate
			New-Object -TypeName $ThisProvider -ArgumentList $Arguments
		}
	}
}