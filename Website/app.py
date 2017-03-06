from flask import Flask, jsonify, render_template, request
from collections import defaultdict
import json

app = Flask(__name__)

# a function to retreive crosscheck stored data
def get_data():
	data_file = open('C:\\Users\\Scott\\OneDrive\\Code\\CrossCheck\\Website\\data.json')
	json_data = data_file.read()
	data = json.loads(json_data)
	return data

@app.route('/')
def index():
	return render_template('index.html')

@app.route('/_get_issues_overview')
def _get_issues_overview():
	# get the data and any arguments passed
	data = get_data()
	pri = request.args.get('priority')
	
	# loop through each object and group it based on its title
	groups = defaultdict(list)
	for obj in data:
		groups[obj['Title']].append(obj)
	
	# format the data. 
	# title was used to group objects so pick this element c[0]
	# priority can be found by picking the priority value of the first element in the grouped data whcih is c[1]
	# count is the length of the grouped objects c[1]
	overview = [{'Title': c[0], 'Priority': c[1][0]['Priority'], 'Count': len(c[1])} for c in groups.items()]

	if pri:
		filtered = [elem for elem in overview if elem['Priority'] == int(pri)]
		return jsonify(filtered)
	else:
		return jsonify(overview)

@app.route('/_get_issues_count')
def _get_issues_count():
	groups = defaultdict(list)
	data = get_data()

	for obj in data:
		groups[obj['Priority']].append(obj['Priority'])
	
	count = [{'Priority':c[0] , 'Count': len(c[1])} for c in groups.items()]
	count.append({'Priority': -1, 'Count': len(data) })
	return jsonify(count)

@app.route('/_get_issues_detail')
def _get_issues_detail():
	# get theargument for priority, /get_issues?priority=0
	pri = request.args.get('priority')
	
	# get the data and filter it if pri was specified
	data = get_data()
	if pri:
		# here we need to convert pri to int as it was passed in as a string
		filtered_data = [elem for elem in data if elem['Priority'] == int(pri)]
		return jsonify(filtered_data)
	else:
		return jsonify(data)


@app.route('/_get_fake_data')
def get_fake_data():
	fakedata = [
		{'issue':'Something Terrible Has Happened','priority':'high','count':4},
		{'issue':'Omfg This is Wrong','priority':'high','count':5},
		{'issue':'Someone has made a mistake','priority':'medium','count':8},
		{'issue':'Small inconsistency spotted','priority':'low','count':1},
		{'issue':'Typo found','priority':'low','count':3}
	]
	return jsonify(fakedata)

# 
if __name__ == '__main__':
	app.run(debug = True, host = '0.0.0.0')