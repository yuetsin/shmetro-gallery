//
//  StationDetailViewController.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/15.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa

class StationDetailViewController: NSViewController {

    
    @objc dynamic var stationName: String = "$STATION_NAME$"
    @objc dynamic var stationNameEn: String = "$STATION_NAME_EN$"
    
    var stationIdStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
}
