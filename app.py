from flask import Flask, jsonify, render_template, request, make_response
from flask_pymongo import PyMongo
from collections import defaultdict

#bson.json_util.dumps to convert BSON to JSON
#bson.json_util.ObjectId Class for mongodb ids to used for querying
from bson.json_util import dumps, ObjectId 

import json

app = Flask("crosscheck")
mongo = PyMongo(app)

# a function to retreive crosscheck stored data
def get_data():
	data_file = open('C:\\Users\\Scott\\OneDrive\\Code\\CrossCheck\\Website\\data.json')
	json_data = data_file.read()
	data = json.loads(json_data)
	return data

# a function to retreive help text
def get_help():
	data_file = open('C:\\Users\\Scott\\OneDrive\\Code\\CrossCheck\\Website\\help.json')
	json_help = data_file.read()
	help = json.loads(json_help)
	return help

# pages
@app.route('/')
def index():
	return render_template('index.html')

@app.route('/checkdetail')
def test():
	title = request.args.get('title')
	return render_template('checkdetail.html', title = title)

@app.route('/logs')
def logs():
	print('wolrd')
	return render_template('logs.html')


# API

#flask defaults to returning html on 404, this sets up a json response instead
@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Not found'}), 404)

@app.route('/_add')
def _add():
	user = mongo.db.user
	user.insert({'name': 'Anthony'})
	return 'User Added!'

@app.route('/crosscheck/api/v1/issues', methods = ['GET'])
def get_issues():
	issues = [doc for doc in mongo.db.issues.find()]
	return dumps({'result': issues})

@app.route('/crosscheck/api/v1/issues/<issue_id>', methods = ['GET'])
def get_issue(issue_id):
	issues = mongo.db.issues.find_one({'_id': ObjectId(issue_id) })
	issues['_id'] = str(issues['_id'])
	return dumps({'result': issues})

@app.route('/crosscheck/api/v1/issues', methods = ['POST'])
def create_issue():
	if not request.json or not 'title' in request.json or not 'priority' in request.json:
		abort(400)
	title = request.json['title']
	priority = request.json['priority']
	description = request.json['description']
	new_issue = {
		'title': request.json['title'],
		'priority': request.json['priority'],
		'description': request.json['description']
	}
	print(new_issue)
	mongo.db.issues.insert_one(new_issue)
	return dumps({'result': new_issue}), 201

@app.route('/crosscheck/api/v1/issues/<issue_id>', methods = ['DELETE'])
def delete_issue(issue_id):
	issues = mongo.db.issues.delete_one({'_id': ObjectId(issue_id) })
	return dumps({'result': True})

@app.route('/_help')
def _help():
	# get the help and any arguments passed
	help = get_help()
	check = request.args.get('check')

	if check:
		filtered_help = [elem for elem in help if elem['Check'] == check]
		return jsonify(filtered_help)
	else:
		return jsonify(help)



@app.route('/_issuesGroupedByTitle')
def _get_issues_overview():
	data = get_data()
	title = request.args.get('title')
	priority = request.args.get('priority')
	
	# loop through each object and group it based on its title
	groups = defaultdict(list)
	for obj in data:
		groups[obj['Title']].append(obj)
	
	# format the data. 
	# title was used to group objects so pick this element c[0]
	# priority can be found by picking the priority value of the first element in the grouped data whcih is c[1]
	# count is the length of the grouped objects c[1]
	overview = [{'Title': c[0], 'Priority': c[1][0]['Priority'], 'Count': len(c[1])} for c in groups.items()]

	if priority:
		filtered = [elem for elem in overview if elem['Priority'] == int(priority)]
		return jsonify(filtered)
	elif title:
		filtered = [elem for elem in overview if elem['Title'] == title]
		return jsonify(filtered)
	else:
		return jsonify(overview)

@app.route('/_issuesGroupedByPriority')
def _get_issues_count():
	groups = defaultdict(list)
	data = get_data()

	for obj in data:
		groups[obj['Priority']].append(obj['Priority'])
	
	count = [{'Priority':c[0] , 'Count': len(c[1])} for c in groups.items()]
	count.append({'Priority': -1, 'Count': len(data) })
	return jsonify(count)


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