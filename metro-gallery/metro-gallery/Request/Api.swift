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
    
    static func getTransitionFee(startStationId: String, endStationId: String, cardType: PayType) -> String {
        return "http://service.shmetro.com/i/p?o=\(startStationId)&d=\(endStationId)&t=\(cardType.rawValue)"
    }
    
    static func getTransitionPath(startStationId: String, endStationId: String, cardType: PayType) -> String {
        return "http://service.shmetro.com/i/c?o=\(startStationId)&d=\(endStationId)&t=\(cardType.rawValue)"
    }
    
    static func getLastTrainTime(stationId: String) -> String {
        return "http://m.shmetro.com/interface/metromap/metromap.aspx?func=fltime&stat_id=\(stationId)"
    }
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


enum RequestItem {
    case allStation
    case transitionFee
    case transitionPath
    case lastTrainTime
    case lineStatus
    case operationHistory
    case lineColor
    case timeTable
    case transitionTable
    case stationDetail
}
