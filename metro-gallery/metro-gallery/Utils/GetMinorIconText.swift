//
//  GetMinorIconText.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/21.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

func getMinorIconText(_ lineId: Int) -> String {
    if lineId != 41 {
        return String(lineId)
    }
    if SuperManager.UILanguage == .chinese {
        return "浦"
    } else {
        return "Pujiang"
    }
}
