//
//  BorderColorGenerator.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/15.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation
import Cocoa

func getBorderColor(_ color: NSColor) -> NSColor {
    return NSColor(calibratedRed: pow(color.redComponent, 2.0),
                   green: pow(color.greenComponent, 2.0),
                   blue: pow(color.blueComponent, 2.0),
                   alpha: 1.0)
}


func getBgColor(_ color: NSColor) -> NSColor {
    return NSColor(calibratedRed: color.redComponent,
                   green: color.greenComponent,
                   blue: color.blueComponent,
                   alpha: 0.5)
}
