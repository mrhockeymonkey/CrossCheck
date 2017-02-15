<#
	.SYNOPSIS
	Standard Class: Issue

	.DESCRIPTION
	An issue is the object raised as the result of a check. 
#>

Enum Priority {
	High
	Medium
	Low
}

class Issue {
	[String]$Title
	[Priority]$Priority
	[String]$Message

	Issue([String]$Title, [Priority]$Priority) {
		$this.Title = $Title
		$this.Priority = $Priority
	}
}