//
//  Station.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

class Station: Equatable {
    static func == (lhs: Station, rhs: Station) -> Bool {
        return lhs.stationCode == rhs.stationCode
    }
    
    init() {
        
    }
    
    init(StationKeyStr: String, StationName: String) {
        stationKeyStr = StationKeyStr
        stationName = StationName
        stationKeyInt = Int(stationKeyStr) ?? -1
    }
    
    var stationKeyStr: String = ""
    // With pre-filling '0', like 莘庄 - "0111"
    
    var stationKeyInt: Int = -1
    // Without pre-filling 0, like 莘庄 - 111
    
    var stationName: String = ""
    // Chinese Station Name
    
    var stationNameEn: String = ""
    // English Station Name
    
    var stationOfLinesId: [Int] = []
    // Line class shallow-copy
    
    var stationCode: String = ""
    // Station identification code
    
    var stationPosition: (Double, Double) = (0.0, 0.0)
    // stationPosition, (Longtitude, Latitude)
    
    var toiletInStation: Bool = false
    
    var toiletPosition: String = ""
    var toiletPositionEn: String = ""
    
    var entranceInfo: String = ""
    var entranceInfoEn: String = ""
    
    var elevatorInfo: String = ""
    var elevatorInfoEn: String = ""
    
    func getStationName(_ language: Language = SuperManager.UILanguage) -> String {
        if language == .chinese {
            return stationName
        } else {
            return stationNameEn
        }
    }
    
    func getToiletInfo(_ language: Language = SuperManager.UILanguage) -> String {
        /* WIP */
        return ""
    }
    
    func getEntranceInfo(_ language: Language = SuperManager.UILanguage) -> String {
        /* WIP */
        return ""
    }
    
    func getElevatorInfo(_ language: Language = SuperManager.UILanguage) -> String {
        /* WIP */
        return ""
    }
}
