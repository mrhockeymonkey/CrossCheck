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
		$ProviderConfig = $ProviderConfig | Where-Object {$_.Name -like $PSBoundParameters['Name']}
	}

	#Loop through config and instatiate the required provider class for each
	$ProviderConfig | ForEach-Object {
		$ThisObject = $_
		
		#Each Provider will have its own custom properties so we grab them here
		#Note they MUST be in the correct order in ProviderConfig.json
		$NoteProperties = $_ | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name
		$Arguments = $NoteProperties | Where-Object {$_ -ne 'Provider'} | ForEach-Object {
			$ThisObject.$_
		}
		Write-Verbose "Instantiating Provider: $($ThisObject.Provider)"
		New-Object -TypeName $ThisObject.Provider -ArgumentList $Arguments
	}
}