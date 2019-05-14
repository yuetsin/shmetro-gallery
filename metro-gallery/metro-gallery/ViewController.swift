//
//  ViewController.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var metroLines: [Line] = []
    var metroStations: [Station] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        InitData(lineCompletion: { (lines) in
            self.metroLines = lines
        }, stationCompletion: { (stations) in
            self.metroStations = stations
        })
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

