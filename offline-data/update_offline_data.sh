#!/usr/bin/env bash 

python3 data_grabber/station_detail.py

python3 station_parser/station_code_aggregate.py

python3 zh_en_mapper/zh_en_mapper.py