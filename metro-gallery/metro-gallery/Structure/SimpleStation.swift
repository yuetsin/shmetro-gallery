//
//  SimpleStation.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/15.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation


class SimpleStation {
    
    init(StationKeyStr: String, StationName: String) {
        stationKeyStr = StationKeyStr
        stationName = StationName
        stationKeyInt = Int(stationKeyStr) ?? -1
        stationNameEn = EnglishStationNameManager.getEnglishStationName(chineseName: stationName)
        
        if stationNameEn == "" {
            NSLog("Failed to translate chinese station name", stationName)
        }
    }
    
    var stationKeyStr: String = ""
    // With pre-filling '0', like 莘庄 - "0111"
    
    var stationKeyInt: Int = -1
    // Without pre-filling 0, like 莘庄 - 111
    
    var stationName: String = ""
    // Chinese Station Name
    
    var stationNameEn: String = ""
    // English Station Name
}
