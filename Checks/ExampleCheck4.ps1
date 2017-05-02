<#
	.SYNOPSIS
	Multiple checks in the same file

	.DESCRIPTION
	Here multiple checks have been define in the same file to help better organize like checks
#>

Check ExampleCheck3a Low {
	$KnownCriminals = Get-DataProvider -Name 'UserCrb' | Import-CachedData | Where-Object {$_.Criminal -eq $true}

	$KnownCriminals | ForEach-Object {
		Write-Output "$($_.User) has not passed his CRB"
	}
}

Check ExampleCheck3b Medium {
	$User30 = Get-DataProvider -Name 'UserCrb' | Import-CachedData | Where-Object {$_.User -eq 'User30'}

	If ($User30) {
		Write-Output "User30 is exempt from a CRB but contained in the CRB database"
	}
}