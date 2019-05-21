//
//  GetLineTextColor.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/21.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa

func getLineTextColor(_ lineId: Int) -> NSColor {
    switch lineId {
    case 1, 4, 5, 6, 8, 11, 12, 17, 41:
        return .white
    case 2, 3, 7, 9, 10, 13, 16:
        return .black
    default:
        return .gray
    }
}
