{
        "line": self.line,
        "stat_id": self.stat_id,
        "stat_id_str": strlen(self.stat_id) == 4 ? self.stat_id : "0" + self.stat_id,
        "name": self.name,
        "station_code": self.station_code,
        "first_time": self.first_time,
        "first_time_desc": self.first_time_desc,
        "last_time": self.last_time,
        "last_time_desc": self.first_time_desc,
        "direction": self.direction,
        "direction_str": self.direction ? "上行" : "下行",
        "description": self.description,
        "firstarrival_time": self.firstarrival_time,
        "lastarrival_time": self.lastarrival_time
    }