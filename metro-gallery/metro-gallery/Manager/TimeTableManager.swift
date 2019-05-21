//
//  TimeTableManager.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/20.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import SwiftyJSON
import Foundation

class TimeTableManager {
    
    static var timeTable: JSON = []
    
    static var stationTimeTable: [JSON] = []
    
    static let lineCode: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "16", "17", "41"]
    
    static func initTimeTableData() {
        if let path = Bundle.main.path(forResource: "offline-data/station_timetable", ofType: "json") {
            do {
                let stationTimeTableBlocks = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                TimeTableManager.timeTable = try! JSON(data: stationTimeTableBlocks)
            } catch {
                // handle error
            }
        }
        
        for lineCodeStr in TimeTableManager.lineCode {
            if let path = Bundle.main.path(forResource: "offline-data/timetable/timetable_line_\(lineCodeStr)", ofType: "json") {
                do {
                    let stationTimeTableBlocks = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let timeTableJson = try! JSON(data: stationTimeTableBlocks)
                    for timeItem in timeTableJson.array! {
                        if timeItem.dictionary?["first_time"]?.stringValue.count ?? 0 < 4 && timeItem.dictionary?["last_time"]?.stringValue.count ?? 0 < 4 {
                            continue
                        }
                        stationTimeTable.append(timeItem)
                    }
                } catch {
                    // handle error
                }
            }
        }
    }
    
    static func getTimeTableRelatedStation(_ stationCode: String) -> [JSON] {
        var resultJson: [JSON] = []
        for tableItem in TimeTableManager.stationTimeTable {
            if tableItem.dictionary!["station_code"]!.stringValue == stationCode {
                resultJson.append(tableItem)
            }
        }
        return resultJson
    }
}
