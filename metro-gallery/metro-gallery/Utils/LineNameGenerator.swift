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

func generateDisplayName(_ lineId: Int, _ language: Language = SuperManager.UILanguage) -> String {
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


func generateSelectTime(_ lineId: Int, _ destination: String, _ language: Language = SuperManager.UILanguage) -> String {
    if language == .chinese {
        let cleanDestination = destination.replacingOccurrences(of: "往", with: "往「").replacingOccurrences(of: "方向", with: "」方向")
        return "\(generateDisplayName(lineId, language))，\(cleanDestination)"
    } else {
        var ringInfo = ""
        
        if destination.contains("内环") {
            ringInfo = "Inner Ring"
        } else if destination.contains("外环") {
            ringInfo = "Outer Ring"
        }
        
        let chineseStationPhase = destination.components(separatedBy: "，")[0]
        
        var englishStationName = ""
        
        if chineseStationPhase.starts(with: "往") {
            let range = (chineseStationPhase.index(
                chineseStationPhase.startIndex, offsetBy: 1))..<(
                    chineseStationPhase.index(
                        chineseStationPhase.endIndex, offsetBy: -2))
            
            let chineseParsedName = chineseStationPhase[range]
            englishStationName = EnglishStationNameManager.getEnglishStationName(chineseName: String(chineseParsedName))
            
            if englishStationName == "" {
                NSLog("Error parsing chinese station name ", chineseStationPhase)
            }
        }
        
        var resultStr = ""
        if ringInfo != "" {
            resultStr += " " + ringInfo
        }
        
        if englishStationName != "" {
            resultStr += ", Bound for \"\(englishStationName)\""
        }
        
        return "\(generateDisplayName(lineId, language))\(resultStr)"
    }
}
