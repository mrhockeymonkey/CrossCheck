<#
	.DESCRIPTION
	A provider to retreive data via restful api

	.EXAMPLE
	{
		"Provider": "RestProvider",
		"Config": [
			{
				"Name": "ExampleData3",
				"Source": "https://jsonplaceholder.typicode.com/users", 
				"ContentType": "application/json"
			}
		]
	}
#>

class RestProvider : Provider {
	[String]$ContentType
	
	RestProvider([String]$Name, [String]$Source, [String]$ContentType) : base ('RestProvider', $Name, $Source) {
		$this.ContentType= $ContentType
	}

	#Override GetData method for REST
	[PSObject]GetData() {
		$Params = @{
			Method = 'GET'
			Uri = $this.Source
			ContentType = $this.ContentType
		}
		$Data = Invoke-RestMethod @Params
		Return $Data
	}
}
