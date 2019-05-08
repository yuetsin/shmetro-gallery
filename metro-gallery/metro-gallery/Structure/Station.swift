//
//  Station.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

class Station {
    var stationKeyStr: String = ""
    // With pre-filling '0', like 莘庄 - "0111"
    
    var stationKeyInt: Int = -1
    // Without pre-filling 0, like 莘庄 - 111
    
    var stationName: String = ""
    // Chinese Station Name
    
    var stationNameEn: String = ""
    // English Station Name
    
    var stationOfLines: [Line] = []
    // Line class shallow-copy
    
    var stationCode: String = ""
    // Station identification code
    
    var stationPosition: (Double, Double) = (0.0, 0.0)
    // stationPosition, (Longtitude, Latitude)
    
    private var toiletPosition: String = ""
    private var toiletPositionEn: String = ""
    
    private var entranceInfo: String = ""
    private var entranceInfoEn: String = ""
    
    func getToiletInfo(_ language: Language = SuperManager.UILanguage) -> String {
        /* WIP */
        return ""
    }
    
    func getEntranceInfo(_ language: Language = SuperManager.UILanguage) -> String {
        /* WIP */
        return ""
    }
}
