//
//  Line.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import Foundation

class Line {
    
    init(LineId: Int, PrimColor: NSColor, BgColor: NSColor) {
        lineId = LineId
        primaryColor = PrimColor
        bgColor = BgColor
    }
    
    var lineId: Int = -1
    // Numeric, 浦江线 referred as Line 41
    
    var primaryColor: NSColor = NSColor.white
    
    var bgColor: NSColor = NSColor.black
    
    var stationInLines: [Line] = []
    // Station class shallow-copy
    
    func lineDisplayName() -> String {
        return generateDisplayName(self.lineId)
    }
}
