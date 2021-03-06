//
//  SuperManager.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

class SuperManager {
    static var UILanguage: Language = .english
    static var requestMode: ReqMode = .offline
    
    static var acessibilityMode: Bool = true
    
    static var Lines: [Line] = []
    static var Stations: [Line] = []
}


enum Language: Int {
    case chinese = 0
    /* Simplified Chinese */
    
    case english = 1
    /* English */
}

enum ReqMode {
    case online
    /* Use latest data from shmetro website */
    
    case offline
    /* Use static local data */
}

enum PayType: Int {
    case transitionCard = 0
    /* Paid via Shanghai Transition Card */
    
    case singleTicket = 1
    /* Paid via Single Ticket */
}
