import json
from collections import defaultdict


data_file = open('C:\\Users\\Scott\\OneDrive\\Code\\CrossCheck\\Website\\data.json')
json_data = data_file.read()
data = json.loads(json_data)

#pri = '0'
#filt = [elem for elem in data if elem['Priority'] == pri]

#print(data)

groups = defaultdict(list)

for obj in data:
    groups[obj['Title']].append(obj)
[{'Title': c[0], 'Count': len(c[1])} for c in groups.items()]
new_list = list(groups.values())
print(new_list)