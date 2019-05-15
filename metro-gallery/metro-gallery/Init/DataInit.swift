//
//  DataInit.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import Foundation

import SwiftHEXColors
import Alamofire
import SwiftyJSON

func InitData(lineCompletion: @escaping ([Line]) -> Void,
              stationCompletion: @escaping ([Station]) -> Void) -> Void {
    if SuperManager.requestMode == .online {
        onlineInitData(lineCompletion, stationCompletion)
    } else {
        offlineInitData(lineCompletion, stationCompletion)
    }
}

fileprivate func onlineInitData(_ lineCompletion: @escaping ([Line]) -> Void,
                    _ stationCompletion: @escaping ([Station]) -> Void) -> Void {
    Alamofire.request(GetApi.getAllStation, method: .get).response { (statResponse) in
        let stationsJson = try! JSON(data: statResponse.data!)
        var stationData: [Station] = []
        for station in stationsJson.array! {
            stationData.append(Station(StationKeyStr: station["key"].string!, StationName: station["value"].string!))
        }
        stationCompletion(stationData)
    }
    
    Alamofire.request(PostApi.getLineColor, method: .post).response { (statResponse) in
        let lineJson = try! JSON(data: statResponse.data!)
        var lineData: [Line] = []
        
        for line in lineJson.array! {
            let primaryColor: NSColor = NSColor(hexString: line["color"].stringValue)!
            let backgroundColor: NSColor = NSColor(hexString: line["bgcolor"].stringValue)!
            lineData.append(Line(LineId: line["line_no"].intValue, PrimColor: primaryColor, BgColor: backgroundColor))
        }
        lineCompletion(lineData)
    }
}

fileprivate func offlineInitData(_ lineCompletion: @escaping ([Line]) -> Void,
                     _ stationCompletion: @escaping ([Station]) -> Void) -> Void {
    return
}
