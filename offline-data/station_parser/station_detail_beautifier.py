#!/usr/bin/env python

import json
from pprint import pprint
with open('../station_detail.json') as sdt_f:
    raw_stations = json.load(sdt_f)


for i in raw_stations:
    ps = i['toilet_position']
    print(i['toilet_position'])

with open('../station_code_mapping.json', 'w') as scm_f:
    json.dump(raw_stations, scm_f)
