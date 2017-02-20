from flask import Flask, jsonify, render_template, request

app = Flask(__name__)

data = [
	{'issue':'Something Terrible Has Happened','priority':'high','count':4},
	{'issue':'Omfg This is Wrong','priority':'high','count':5},
	{'issue':'Someone has made a mistake','priority':'medium','count':8},
	{'issue':'Small inconsistency spotted','priority':'low','count':1},
	{'issue':'Typo found','priority':'low','count':3}
]

@app.route('/')
def index():
	return render_template('index.html')

@app.route('/_get_issues')
def high():
	req_pri = request.args.get('priority')
	
	if req_pri:
		filtered_data = [elem for elem in data if elem['priority'] == req_pri]
		return jsonify(filtered_data)
	else:
		return jsonify(data)

if __name__ == '__main__':
	app.run(debug = True, host = '0.0.0.0')