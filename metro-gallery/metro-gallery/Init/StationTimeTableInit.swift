//
//  StationTimeTableInit.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/16.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Alamofire
import SwiftyJSON

import Foundation


func InitTimeTableData(stationKey: String, timeTableCompletion: @escaping ([TimeTable]) -> Void) -> Void {
    if SuperManager.requestMode == .online {
        onlineInitData(stationKey, timeTableCompletion)
    } else {
        offlineInitData(stationKey, timeTableCompletion)
    }
}

fileprivate func onlineInitData(_ stationKey: String, _ timeTableCompletion: @escaping ([TimeTable]) -> Void) -> Void {
    Alamofire.request(PostApi.getStationTimeTable(stationKey: stationKey), method: .post)
}

fileprivate func offlineInitData(_ stationKey: String, _ timeTableCompletion: @escaping ([TimeTable]) -> Void) -> Void {
    
}
