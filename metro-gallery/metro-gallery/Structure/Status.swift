//
//  Status.swift
//  metro-gallery
//
//  Created by 法好 on 2019/5/23.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import SwiftyJSON
import Foundation

class Status {
    
    fileprivate static var operationStatusRawJson: JSON?
    
    static func updateStatus(json: JSON) -> Void {
        Status.operationStatusRawJson = json
        Status.lastUpdateTime = Date.init()
        
    }
    
    fileprivate static var lastUpdateTime: Date?
    
    static func getOperationStatus(_ lineId: Int) -> JSON? {
        if operationStatusRawJson == nil {
            return nil
        }
        for line in (operationStatusRawJson?.array)! {
            if line.dictionary!["disLine"]!.stringValue == "\(lineId)" {
                return line
            }
        }
        return nil
    }
}
