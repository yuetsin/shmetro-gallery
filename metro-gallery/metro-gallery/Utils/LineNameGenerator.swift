//
//  LineNameGenerator.swift
//  metro-gallery
//
//  Manages the line display name
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

func generateDisplayName(_ lineId: Int, language: Language = SuperManager.UILanguage) -> String {
    if language == .chinese {
        if lineId == 41 {
            return "浦江线"
        }
        return "\(lineId) 号线"
    } else {
        if lineId == 41 {
            return "Line Pujiang"
        }
        return "Line \(lineId)"
    }
}
