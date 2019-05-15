//
//  RawStationDataInit.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/15.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Alamofire
import Foundation

func requestRawData(_ lineId: Int, _ completion: ((String) -> (Void))) -> Void {
    Alamofire.request(Uri.queryUrl, method: .get).response(completionHandler: { (dataResponse) in
        Alamofire.request(Uri.postUrl, method: .post, parameters: [
            "act": "slsddl",
            "ln": lineId,
            "sc": ""
        ]).response(completionHandler: { (dataResponse) in
            let ala: String = String(data: dataResponse.data!, encoding: .utf8)!
            
        })
    })
}
