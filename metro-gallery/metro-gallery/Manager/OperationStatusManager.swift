//
//  OperationStatusManager.swift
//  metro-gallery
//
//  Created by 法好 on 2019/5/23.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class OperationStatusManager {
    static func updateStatus(_ completion: @escaping () -> Void) -> Void {
        Alamofire.request(PostApi.getLineStatus, method: .post).response(completionHandler: { statusResp in
            if statusResp.data == nil {
//                errHandler(statusResp.response?.statusCode)
                return
            }
            do {
                let statusJson = try! JSON(data: statusResp.data!)
                Status.updateStatus(json: statusJson)
                completion()
            } catch {
                // catch exception
                return
            }
        })
    }

    static func getStatus(_ lineId: Int) -> OperatingStatus {
        let statusJson: JSON? = Status.getOperationStatus(lineId)
        if statusJson == nil {
            return .unknown
        }

        let statusCode = statusJson?.dictionary!["status"]?.stringValue
        if statusCode == "" {
            /* 0 means normally operating */
            return .normal
        }

        let errContent = statusJson?.dictionary!["content"]
        OperationStatusManager.errCode = statusCode
        OperationStatusManager.errInfo = genLocalizationString(zhHans: "故障信息：\(errContent!)", en: "Detail Message (in Chinese): \(errContent!)")
        return .abnormal
    }

    static var errCode: String?
    static var errInfo: String?
}

enum OperatingStatus {
    case normal
    case abnormal
    case unknown
}

/*

 [
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "1",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "2",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "3",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "4",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "5",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "6",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "7",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "8",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "9",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "10",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "11",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "12",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "13",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "16",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "17",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 },
 {
 "addPerson": "",
 "content": "",
 "date": "",
 "disLine": "41",
 "id": 0,
 "lateTime": "",
 "line": "",
 "status": "0"
 }
 ]

 */
