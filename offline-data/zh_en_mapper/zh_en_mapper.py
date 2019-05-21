#!/usr/bin/env python

import json
from pprint import pprint
with open('../station_detail.json') as sdt_f:
    raw_stations = json.load(sdt_f)

zh_en_mapping = {}


for i in raw_stations:
    if not i['name_cn'] in zh_en_mapping:
        zh_en_mapping.update({
            i['name_cn']: i['name_en']
        })

with open('../zh_en_mapping.json', 'w') as zem_f:
    json.dump(zh_en_mapping, zem_f)
