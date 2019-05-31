//
//  Line.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import Foundation

class Line: Equatable {
    
    static func == (lhs: Line, rhs: Line) -> Bool {
        return lhs.lineId == rhs.lineId
    }
    
    
    init(LineId: Int, PrimColor: NSColor, BgColor: NSColor) {
        lineId = LineId
        primaryColor = PrimColor
        bgColor = BgColor
    }
    
    
    var lineId: Int = -1
    // Numeric, 浦江线 referred as Line 41
    
    var primaryColor: NSColor = NSColor.white
    
    var bgColor: NSColor = NSColor.black
    
    var stationInLines: [SimpleStation] = []
    // Stations of this line
    
    func lineDisplayName() -> String {
        return generateDisplayName(self.lineId)
    }
    
    var operatingStatus: OperatingStatus = .unknown
    var operatingErrInfo: String?
}
