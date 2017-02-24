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

	#Loop through config and instatiate the required provider class for each
	$ProviderConfig | ForEach-Object {
		#Save the provider name for use in another scope
		$ThisProvider = $_.Provider

		#A defined provider may have 1 or more configs nested underneath, so loop through
		$_.Config | ForEach-Object {
			
			#Filter unwanted providers if user specified name
			If ($PSBoundParameters.ContainsKey('Name')) {
				If ($_.Name -notlike $PSBoundParameters['Name']) {
					Return
				}
			}

			#Get the values of each config property
			#Note definitions must respect the correct order of arguments for this to work
			$Arguments = $_.psobject.properties.value
			
			#Instantiate
			Write-Debug "Instantiating: $ThisProvider ($($Arguments -join ', '))"
			New-Object -TypeName $ThisProvider -ArgumentList $Arguments
		}
	}
}