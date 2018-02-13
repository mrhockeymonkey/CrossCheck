function UpdateIssuesTable(issues) {
    var tabledata = "";
	$.each(issues, function () {
		//create a table row element and sub in values
		var tablerow = `<tr onclick="document.location = 'issue_detail?title=${this.title}'";><td>${this.title}</td><td>${this.priority}</td><td>0</td></tr>`
		tabledata += tablerow
		console.log("Adding Row: " + tablerow);
	});
	$("#issues-table tbody").html(tabledata);
};

function UpdateOverview(issues) {
    $("#overview-all-value").text(issues.length);
    var priorities = [0, 1, 2];
    $.each(priorities, function(n){
        var filtered_issues = FilterIssues(issues,n);
		switch(n){
			case 0:
				$("#overview-high-value").text(filtered_issues.length);
				break;
			case 1:
				$("#overview-medium-value").text(filtered_issues.length);
				break;
			case 2:
				$("#overview-low-value").text(filtered_issues.length);
				break;
		};
    });
};

function FilterIssuesByPriority(issues, priority) {
    var filtered_issues = issues.filter(function(issue){
        return issue.priority == priority;
    });
    return filtered_issues;
};

function GetIssuesByPriority(priority) {
	$.getJSON('/crosscheck/api/v1/issues', function(json){
		var issues = json.result;
		console.log(issues);
        //Before we do any filtering we update the overview
        UpdateOverview(issues);
        //Update the issues table depending on the priority requested
        switch(priority){
            case 0:
                issues = FilterIssuesByPriority(issues,0);
                break;
            case 1:
                issues = FilterIssuesByPriority(issues,1);
                break;
            case 2:
                issues = FilterIssuesByPriority(issues,2);
                break;
        };
		//Update issues table
        UpdateIssuesTable(issues);
    });
};