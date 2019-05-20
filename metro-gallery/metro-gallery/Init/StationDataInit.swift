//
//  StationDataInit.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/15.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation


func initStationData(simpleStation: SimpleStation, stationDetailCompletion: @escaping (Station?) -> Void) -> Void {
    if SuperManager.requestMode == .online {
        onlineInitData(simpleStation, stationDetailCompletion)
    } else {
        offlineInitData(simpleStation, stationDetailCompletion)
    }
}

fileprivate func onlineInitData(_ simpleStation: SimpleStation, _ stationDetailCompletion: @escaping (Station?) -> Void) -> Void {
    Alamofire.request(PostApi.getStationDetail(stationCode: simpleStation.stationKeyStr), method: .post)
        .response(completionHandler: { (statResponse) in
            let station: Station = Station(StationKeyStr: simpleStation.stationKeyStr,
                                           StationName: simpleStation.stationName)
            
            let stationDetail = try! JSON(data: statResponse.data!)
            let stationJson = stationDetail.array![0]
            
            station.stationName = stationJson["name_cn"].stringValue
            station.stationNameEn = stationJson["name_en"].stringValue
            station.stationCode = stationJson["station_code"].stringValue
            
            station.stationOfLinesId.removeAll()
            for id in stationJson["lines"].stringValue.components(separatedBy: CharacterSet(charactersIn: ",，")) {
                let stationInt = Int(id)
                if stationInt != nil {
                    station.stationOfLinesId.append(stationInt!)
                } else {
                    stationDetailCompletion(nil)
                    return
                }
            }
            station.stationPosition = (stationJson["latitude"].doubleValue, stationJson["longitude"].doubleValue)
            
            station.toiletInStation = stationJson["toilet_inside"].boolValue
            station.toiletPosition = stationJson["toilet_position"].stringValue
            station.toiletPositionEn = stationJson["toilet_position_en"].stringValue
            
            station.entranceInfo = stationJson["entrance_info"].stringValue
            station.entranceInfoEn = stationJson["entrance_info_en"].stringValue
            
            station.elevatorInfo = stationJson["elevator"].stringValue
            station.elevatorInfoEn = stationJson["elevator_en"].stringValue
            
            stationDetailCompletion(station)
    })
}

fileprivate func offlineInitData(_ simpleStation: SimpleStation, _ stationDetailCompletion: @escaping (Station?) -> Void) -> Void {
    
    let station: Station = Station(StationKeyStr: simpleStation.stationKeyStr, StationName: simpleStation.stationName)
    
    let stationJson = OfflineStationManager.getStationById("\(simpleStation.stationKeyInt)")
    
    station.stationName = stationJson["name_cn"].stringValue
    station.stationNameEn = stationJson["name_en"].stringValue
    station.stationCode = stationJson["station_code"].stringValue
    
    station.stationOfLinesId.removeAll()
    for id in stationJson["lines"].stringValue.components(separatedBy: CharacterSet(charactersIn: ",，")) {
        let stationInt = Int(id)
        if stationInt != nil {
            station.stationOfLinesId.append(stationInt!)
        }
    }
    
    station.stationPosition = (stationJson["latitude"].doubleValue, stationJson["longitude"].doubleValue)
    
    station.toiletInStation = stationJson["toilet_inside"].boolValue
    station.toiletPosition = stationJson["toilet_position"].stringValue
    station.toiletPositionEn = stationJson["toilet_position_en"].stringValue
    
    station.entranceInfo = stationJson["entrance_info"].stringValue
    station.entranceInfoEn = stationJson["entrance_info_en"].stringValue
    
    station.elevatorInfo = stationJson["elevator"].stringValue
    station.elevatorInfoEn = stationJson["elevator_en"].stringValue
    
    stationDetailCompletion(station)
    return
}
