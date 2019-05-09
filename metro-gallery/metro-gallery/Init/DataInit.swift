//
//  DataInit.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

func InitData(lineData: inout [Line], stationData: inout [Station]) -> Bool {
    if SuperManager.requestMode == .online {
        return onlineInitData(lineData: &lineData, stationData: &stationData)
    } else {
        return offlineInitData(lineData: &lineData, stationData: &stationData)
    }
}

func onlineInitData(lineData: inout [Line], stationData: inout [Station]) -> Bool {
    return true
}

func offlineInitData(lineData: inout [Line], stationData: inout [Station]) -> Bool {
    return true
}
