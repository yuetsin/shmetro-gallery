//
//  DataInit.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

func InitData() -> Bool {
    if SuperManager.requestMode == .online {
        return onlineInitData()
    } else {
        return offlineInitData()
    }
}


func onlineInitData() -> Bool {
    return true
}

func offlineInitData() -> Bool {
    return true
}
