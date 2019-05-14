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

    @IBOutlet var outlineView: NSOutlineView!

    override func viewDidLoad() {
        super.viewDidLoad()
        outlineView.target = self
        outlineView.delegate = self
        outlineView.dataSource = self
        // Do any additional setup after loading the view.
        InitData(lineCompletion: { lines in
            self.metroLines = lines
            self.outlineView.reloadData()
        }, stationCompletion: { stations in
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
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        return metroLines.count
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return false
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        return metroLines[index]
    }
}

extension ViewController: NSOutlineViewDelegate {
    fileprivate enum CellIdentifiers {
        static let ImgCell = "ImgCellID"
    }

    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var image: NSImage?
        var text: String = ""

        // 1
        let item = item as? Line

        // 2
        image = nil
        text = item?.lineDisplayName() ?? "未知"

        // 3
        if let cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.ImgCell), owner: self) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.imageView?.image = image ?? nil
            return cell
        }
        return nil
    }
}
