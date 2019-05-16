//
//  TimeTable.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/16.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import SwiftyJSON
import Foundation

class TimeTable {
    
    var lineNo: Int = -1
    var stationId: String = ""
    var stationName: String = ""
    
    var startTime: String = ""
    var endTime: String = ""
    
    var startTimeOffset: JSON = JSON.null
    var endTimeOffset: JSON = JSON.null
    
    var direction: Int = 0
    /* direction can be -1 and 1. */
    
    var terminal: String = ""
    /* Terminal station this train bounds for */
}
