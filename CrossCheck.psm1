
#Load Functions
Try {
	Get-ChildItem $PSScriptRoot\Functions | ForEach-Object {
		$FunctionName = $_.Name
		Write-Debug "Loading Function: $FunctionName"
		. $_.FullName
	}
}
Catch {
	Write-Warning ("Could not load $($FunctionName): $($_.Exception.Message)")
	Continue
}