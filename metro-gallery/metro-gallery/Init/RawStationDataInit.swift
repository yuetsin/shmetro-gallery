//
//  RawStationDataInit.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/15.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Alamofire
import Foundation

func requestRawData(_ lineId: Int, _ completion: @escaping (([SimpleStation]) -> (Void))) -> Void {
    Alamofire.request(Uri.queryUrl, method: .get).response(completionHandler: { (dataResponse) in
        Alamofire.request(Uri.postUrl, method: .post, parameters: [
            "act": "slsddl",
            "ln": lineId,
            "sc": ""
        ]).response(completionHandler: { (dataResponse) in
            let stationStr: String = String(data: dataResponse.data!, encoding: .utf8)!
            for stat in stationStr.components(separatedBy: "\n") {
                let splitedString = stat.replacingOccurrences(of: "</option><option value=\"", with: "@")
                                        .replacingOccurrences(of: "\" >", with: "@")
                                        .replacingOccurrences(of: "<option value=\"", with: "")
                                        .replacingOccurrences(of: "</option>", with: "")
                let strArray = splitedString.components(separatedBy: "@")
                var simpleStationArray: [SimpleStation] = []
                for i in 0..<strArray.count {
                    if i % 2 == 1 {
                        continue
                    }
                    simpleStationArray.append(SimpleStation(StationKeyStr: strArray[i], StationName: strArray[i + 1]))
                }
                
                completion(simpleStationArray)
            }
        })
    })
}
