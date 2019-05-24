//
//  getTimeStamp.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/24.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Foundation

func currentTime() -> String {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
    return dateformatter.string(from: Date())
}
