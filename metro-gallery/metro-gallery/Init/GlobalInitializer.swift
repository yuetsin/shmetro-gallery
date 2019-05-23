//
//  GlobalInitializer.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/21.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

func globalInit() {
    /* Loading UI Preferences. Should be done at very first time. */
    loadPreferences()
    
    EnglishStationNameManager.initStationNameMapping()
    OfflineStationManager.initStationData()
    TimeTableManager.initTimeTableData()
}
