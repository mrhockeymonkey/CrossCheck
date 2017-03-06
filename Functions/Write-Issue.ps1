<#
	.SYNOPSIS
	Write an issue found when cross checking data

	.DESCRIPTION
	This cmdlet is used to raise a new issue in cross check scripts that will be returned
	on invoking a check. 

	.EXAMPLE
	Write-Issue -Title 'Missing Important Data' -Priority High
#>

Function Write-Issue {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true)]
		[String]$Title,

		[Parameter(Mandatory = $true)]
		[ValidateSet('High','Medium','Low')]
		[Priority]$Priority,

		[String]$Message
	)

	$Issue = [Issue]::New($Title, $Priority)

	If ($PSBoundParameters.ContainsKey('Message')) {
		$Issue.Message = $PSBoundParameters['Message']
	}

	Write-Output $Issue
}