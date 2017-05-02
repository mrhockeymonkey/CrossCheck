# CrossCheck
CrossCheck is a passive auditing system that can pull multiple disperate sources of data 
together and cross refernece them to ensure there are no discrepancies. CrossCheck will not
make any changes or send any alerts upon finding issues. If possible, anything that 
can be remediated automatically should defined in management. 

This is aimed at making systems administrators aware of administrative and configuration
discrepancies when working with multiple tools, databases, etc


## Upcoming
* A python webserver 
* json files to define data sources
* json files to define checks
* exporting check results to htm files
* making it all look very pretty
* maybe a snooze button for checks?
* Documentation on writing providers

## How to Define Sources
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

## How to Define Checks
```json

```

## How Check are processed?

* Data should be imported from each source on a schedule, few times or once a day
* Retreived data should be cached to disk when not in use by a check (clixml? whats the most performant)
* Eachg check that runs should get the data sources it needs in definition from disk to memory and then query
* This way only data that is needed is in memory for the amount of time it takes to complete the check
* Checks are invokable PS1 files that take 
* Multithreading