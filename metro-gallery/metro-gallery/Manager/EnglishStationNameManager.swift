//
//  EnglishStationNameManager.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/21.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import SwiftyJSON
import Foundation


class EnglishStationNameManager {
    
    static var stationNameMapper: JSON = JSON.null
    
    static func initStationNameMapping() {
        if let path = Bundle.main.path(forResource: "offline-data/zh_en_mapping", ofType: "json") {
            do {
                let stationTimeTableBlocks = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                EnglishStationNameManager.stationNameMapper = try! JSON(data: stationTimeTableBlocks)
            } catch {
                // handle error
            }
        }
    }
    
    static func getEnglishStationName(chineseName name: String) -> String {
        return EnglishStationNameManager.stationNameMapper.dictionary![name]?.stringValue ?? ""
    }
}
