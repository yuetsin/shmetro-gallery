//
//  Api.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/9.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

class GetApi {
    static let getAllStation: String = "http://m.shmetro.com/core/shmetro/mdstationinfoback.ashx?act=getAllStations"
}

class PostApi {
    static let getLineStatus: String = "http://service.shmetro.com/i/sm?method=doGetAllLineStatus"
    static let getOperationHistory: String = "http://service.shmetro.com/i/sm?method=doGetYxqkDetail"
    static let getLineColor: String = "http://m.shmetro.com/interface/metromap/metromap.aspx?func=lines"
    
    static func getTimeTable(lineCode: String) -> String {
        return "http://m.shmetro.com/interface/metromap/metromap.aspx?func=fltime&line=\(lineCode)"
    }
    
    static func getTransitionTable(lineCode: String) -> String {
        return "http://m.shmetro.com/interface/metromap/metromap.aspx?func=exfltime&line1=\(lineCode)"
    }
    
    static func getStationDetail(stationCode: String) -> String {
        return "http://m.shmetro.com/interface/metromap/metromap.aspx?func=stationInfo&stat_id=\(stationCode)"
    }
}

