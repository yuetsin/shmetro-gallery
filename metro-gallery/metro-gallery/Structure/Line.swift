//
//  Line.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

class Line {
    let lineId: Int = -1
    // Numeric, 浦江线 referred as Line 41
    
    let primaryColor: Int32 = 0xfffef9
    
    let bgColor: Int32 = 0x000000
    
    var stationInLines: [Line] = []
    // Station class shallow-copy
    
    func lineDisplayName() -> String {
        return generateDisplayName(self.lineId)
    }
}
