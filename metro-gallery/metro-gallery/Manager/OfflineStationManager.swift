//
//  OfflineStationManager.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/20.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import SwiftyJSON
import Foundation

class OfflineStationManager {
    static var stations: JSON = JSON.null
    
    static func getStationById(_ id: String) -> JSON {

        for stat in OfflineStationManager.stations.array! {
            if stat.dictionary!["stat_id"]?.stringValue == id {
                return stat
            }
        }
        
        return JSON.null
    }
    
    static func initStationData() {
        if let path = Bundle.main.path(forResource: "offline-data/station_detail", ofType: "json") {
            do {
                let stationDetailBlocks = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                OfflineStationManager.stations = try! JSON(data: stationDetailBlocks)
            } catch {
                // handle error
            }
        }
    }
}
