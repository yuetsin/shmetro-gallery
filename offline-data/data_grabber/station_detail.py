#!/usr/bin/env python

import json
import requests
from pprint import pprint

stationDetailUrl = "http://m.shmetro.com/interface/metromap/metromap.aspx?func=stationInfo&stat_id=%s"

stationTimeTableUrl = "http://m.shmetro.com/interface/metromap/metromap.aspx?func=fltime&stat_id=%s"

with open('../all_station.json', 'r') as station_f:
    station_data = json.load(station_f)

station_detail = []

unique_station_code_detail = []

station_timetable = []

sess = requests.Session()


for s in station_data:
    f = sess.post(stationDetailUrl % s['key'])
    station_detail.append(json.loads(f.content.decode()))

    f = sess.post(stationTimeTableUrl % s['key'])

    tmt = json.loads(f.content.decode())
    for itm in tmt:
        if itm['first_time_desc'] != '':
            itm['first_time_desc'] = json.loads(itm['first_time_desc'])

        if itm['last_time_desc'] != '':
            itm['last_time_desc'] = json.loads(itm['last_time_desc'])

    station_timetable.append(tmt)
    # pprint(tmt)
    # input()

with open('../station_detail.json', 'w') as detail_f:
    json.dump(station_detail, detail_f)


with open('../station_timetable.json', 'w') as tt_f:
    json.dump(station_timetable, tt_f)
