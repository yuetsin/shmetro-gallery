//
//  ViewController.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import FlexibleImage

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
    
    func updateStatus() {
        let selectedRow = outlineView.selectedRow
        let id = outlineView.item(atRow: selectedRow)
        outlineView.setNeedsDisplay(outlineView.rect(ofRow: selectedRow))
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
    
    func outlineView(_ outlineView: NSOutlineView, didAdd rowView: NSTableRowView, forRow row: Int) {
        rowView.backgroundColor = .clear
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        updateStatus()
    }
    
    func outlineView(_ outlineView: NSOutlineView, willDisplayCell cell: Any, for tableColumn: NSTableColumn?, item: Any) {
        let rowNo: Int = outlineView.row(forItem: item)
        var bgColor: NSColor = .blue
        if (outlineView.selectedRowIndexes.contains(rowNo)) {
            bgColor = metroLines[rowNo].primaryColor
        } else {
            bgColor = .clear
        }
        
        let cellView = (cell as! NSTableCellView)
        cellView.wantsLayer = true
        cellView.layer?.isOpaque = true
        cellView.layer?.opacity = 0.5
        cellView.textField?.drawsBackground = true
        cellView.layer?.backgroundColor = (bgColor as! CGColor)
    }
    /*
     -(void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item {
     
     NSUInteger rowNo = [outlineView rowForItem:item];
     
     NSColor *backgroundColor;
     if ( [[outlineView selectedRowIndexes] containsIndex:rowNo] ) {
     backgroundColor = // Highlighted color;
     }
     else {
     backgroundColor = // Normal background color;
     }
     
     [cell setBackgroundColor: backgroundColor];
     }
     */
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        
        var text: String = ""

        // 1
        let item = item as? Line

        
        // 2
        let image: NSImage? = drawIconByColor(item!.primaryColor)
        text = item?.lineDisplayName() ?? "未知"

        // 3
        if let cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.ImgCell), owner: self) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.imageView?.image = image
            return cell
        }
        return nil
    }
}

class AudioCellView: NSTableRowView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    override var isEmphasized: Bool {
        set {}
        get {
            return false
        }
    }
    
    override var selectionHighlightStyle: NSTableView.SelectionHighlightStyle {
        set {}
        get {
            return .regular
        }
    }
    
    override func drawSelection(in dirtyRect: NSRect) {
        if self.selectionHighlightStyle != .none {
            let selectionRect = NSInsetRect(self.bounds, 2.5, 2.5)
            NSColor(calibratedWhite: 0.85, alpha: 0.6).setFill()
            let selectionPath = NSBezierPath.init(rect: selectionRect)
            selectionPath.fill()
        }
    }
}
