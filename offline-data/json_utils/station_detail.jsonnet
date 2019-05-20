
{
        "stat_id": self.stat_id,
        "stat_id_str": strlen(self.stat_id) == 4 ? self.stat_id : "0" + self.stat_id,
        "name_cn": self.name_cn,
        "name_en": self.name_en,
        "pinyin": self.pinyin,
        "station_code": self.station_code,
        "lines": std.join(',', self.lines_list),
        "lines_list": self.lines_list,
        "longitude": self.longitude,
        "latitude": self.latitude,
        "x": self.x,
        "y": self.y,
        "station_pic": self.station_pic,
        "toilet_inside": self.toilet_inside,
        "toilet_position": self.toilet_position,
        "toilet_position_en": self.toilet_position_en,
        "entrance_info": self.entrance_info,
        "entrance_info_en": self.entrance_info_en,
        "street_pic": self.street_pic,
        "elevator": self.elevator,
        "elevator_en": self.elevator_en
    }
