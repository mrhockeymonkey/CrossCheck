# CrossCheck
CrossCheck is a passive auditing system that can pull multiple disperate sources of data 
together and cross refernece them to ensure there are no discrepancies. CrossCheck will not
make any changes or send any alerts upon finding issues. If possible anything that 
can have a scripted fix is better placed in configuration management. 

This is aimed at making systems administrators aware of administrative and configuration
discrepancies when working with multiple tools, databases, etc


## Roadmap
* A python webserver 
* json files to define data sources
* json files to define checks
* exporting check results to htm files
* making it all look very pretty
* maybe a snooze button for checks?

Sources JSON
```json
{
	"XCProvider" : [
		{
			"Name" : "",
			

		},
		{
			"Name" : "",

		}
	]
}
```