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

extension ViewController: NSOutlineViewDataSource {
    func numberOfRows(in outlineView: NSOutlineView) -> Int {
        return metroLines.count
    }
}

extension ViewController: NSOutlineViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let ImgCell = "ImgCellID"
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var image: NSImage?
        var text: String = ""
        var cellIdentifier: String = ""
        
        // 1
        let item = metroLines[row]
        
        // 2
        image = item.
        text = item.lineDisplayName()
        
        
        // 3
        if let cell = outlineView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.imageView?.image = image ?? nil
            return cell
        }
        return nil
    }
    
}
