#!/usr/bin/env python

import json
from pprint import pprint
with open('../station_detail.json') as sdt_f:
    raw_stations = json.load(sdt_f)

station_code_mapping = {}

for i in raw_stations:
    st_code = i['station_code']
    if st_code == '':
        continue
    if st_code in station_code_mapping:
        station_code_mapping[st_code].append(i['stat_id'])
    else:
        station_code_mapping.update({
            st_code: [i['stat_id']]
        })

pprint(station_code_mapping)
print(len(station_code_mapping))

with open('../station_code_mapping.json', 'w') as scm_f:
    json.dump(station_code_mapping, scm_f)
