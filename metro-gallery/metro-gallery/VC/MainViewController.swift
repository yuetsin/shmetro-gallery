//
//  MainViewController.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/8.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import FlexibleImage

class ViewController: NSViewController, L11nRefreshDelegate {
    static var metroLines: [Line] = []
    var metroStations: [Station] = []

    var delegate: StatusOperatingDelegate?

    var selectedStations: [SimpleStation] = []

    var visitedStationCount: Int = 0
    var targetStationCount: Int = 0
    var metroStationsWithDetail: [Station] = []

    @objc dynamic var finishedLoading = true

    @IBOutlet var loadingRing: NSProgressIndicator!

    @IBOutlet var outlineView: NSOutlineView!
    @IBOutlet var tableView: NSTableView!

    @IBOutlet var stationDisplayTableColumn: NSTableColumn!

    func flushUILocalization() {
        stationDisplayTableColumn.title = genLocalizationString(zhHans: "站点名", en: "Station Name")
    }

    func flushOperatingStatus() {
        OperationStatusManager.updateStatus({
            for line in ViewController.metroLines {
                line.operatingStatus = OperationStatusManager.getStatus(line.lineId)
                if line.operatingStatus == .abnormal {
                    line.operatingErrInfo = OperationStatusManager.errInfo
                }
            }
            self.updateCurrentLineOperatingStatus()
        })
    }

    func updateCurrentLineOperatingStatus() {
        let currentRowIndex = outlineView.selectedRow
        if currentRowIndex == -1 || currentRowIndex >= ViewController.metroLines.count {
            (view.window?.windowController as! MainWindowController).setStatusIcon(.unknown)
        }

        let currentLine = ViewController.metroLines[currentRowIndex]

        delegate?.setStatusIcon(currentLine.operatingStatus)
    }
    
    func searchStation(_ stationName: String) {
        
    }
    
    func clickStatusDetail() {
        if outlineView.selectedRow < 0 {
            return
        }
        let lineInfo = ViewController.metroLines[outlineView.selectedRow]
        
        let statAlert: NSAlert = NSAlert()
        statAlert.messageText = genLocalizationString(zhHans: "\(generateDisplayName(lineInfo.lineId))运营情况",
            en: "\(generateDisplayName(lineInfo.lineId)) Operating Status")
        statAlert.addButton(withTitle: genLocalizationString(zhHans: "嗯", en: "OK"))
        
        if lineInfo.operatingStatus == .normal {
            statAlert.informativeText = genLocalizationString(zhHans: "\(generateDisplayName(lineInfo.lineId))当前运行正常。\n\n上次更新于：\(OperationStatusManager.lastUpdateTime ?? "未知")", en: "\(generateDisplayName(lineInfo.lineId)) is operating normally.\n\nLast Update Time: \(OperationStatusManager.lastUpdateTime ?? "Unknown")")
            statAlert.alertStyle = NSAlert.Style.informational
            statAlert.icon = NSImage(named: "NSStatusAvailable")
        } else if lineInfo.operatingStatus == .abnormal {
            statAlert.informativeText = genLocalizationString(zhHans: "\(generateDisplayName(lineInfo.lineId))当前运行不正常。\n\(lineInfo.operatingErrInfo ?? "")\n\n上次更新于：\(OperationStatusManager.lastUpdateTime ?? "未知")", en: "\(generateDisplayName(lineInfo.lineId)) is operating abnormally.\n\nLast Update Time: \(OperationStatusManager.lastUpdateTime ?? "Unknown")")
            statAlert.alertStyle = NSAlert.Style.critical
            statAlert.icon = NSImage(named: "NSStatusUnavailable")
        } else {
            statAlert.informativeText = genLocalizationString(zhHans: "\(generateDisplayName(lineInfo.lineId))当前运行状态未知。", en: "\(generateDisplayName(lineInfo.lineId)) operation status is currently unknown.")
            statAlert.alertStyle = NSAlert.Style.warning
            statAlert.icon = NSImage(named: "NSStatusNone")
        }
        statAlert.beginSheetModal(for: view.window!, completionHandler: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        globalInit()

        outlineView.target = self
        outlineView.delegate = self
        outlineView.dataSource = self

        tableView.target = self
        tableView.delegate = self
        tableView.dataSource = self

//        loadingRing.startAnimation(self)

        tableView.doubleAction = #selector(tableViewDoubleClick(_:))

        flushOperatingStatus()
        renderUI()
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    func forceReRender() {
        let tempCache = ViewController.metroLines
        ViewController.metroLines.removeAll()
        outlineView.reloadData()
        ViewController.metroLines = tempCache
        outlineView.reloadData()
        tableView.reloadData()
        outlineView.selectRowIndexes(IndexSet(arrayLiteral: 0), byExtendingSelection: false)
        updateCurrentLineOperatingStatus()
    }

    func renderUI() {
        InitData(lineCompletion: { lines in
            ViewController.metroLines = lines
            self.outlineView.reloadData()
        }, stationCompletion: { stations in
            self.metroStations = stations

            for line in ViewController.metroLines {
                requestRawData(line.lineId, { simpleStations in
                    line.stationInLines = simpleStations
                    self.outlineView.selectRowIndexes(IndexSet(arrayLiteral: 0), byExtendingSelection: false)
                })
            }
            /*
             self.targetStationCount = self.metroStations.count
             for station in self.metroStations {

             InitStationData(station: station, stationDetailCompletion: { statDetail in
             if statDetail != nil {
             self.metroStationsWithDetail.append(statDetail!)
             }
             self.visitedStationCount += 1
             self.loadingRing.doubleValue = Double(self.visitedStationCount) / Double(self.targetStationCount) * self.loadingRing.maxValue
             //                    NSLog("And here we are \(self.loadingRing.doubleValue)")
             if self.targetStationCount == self.visitedStationCount {
             self.finishedLoading = true
             self.outlineView.selectRowIndexes(IndexSet(arrayLiteral: 0), byExtendingSelection: false)
             }
             })
             }
             */

            //            self.finishedLoading = true
        })
    }

    func updateStatus() {
        let lineSelected = ViewController.metroLines[outlineView.selectedRow]
        selectedStations = lineSelected.stationInLines
        updateCurrentLineOperatingStatus()
        tableView.reloadData()
    }

    @objc func tableViewDoubleClick(_ sender: AnyObject) {
        if tableView.selectedRow < 0 {
            return
        }

        let selStation: SimpleStation = selectedStations[tableView.selectedRow]

        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let SDVC = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("StationDetailViewController")) as! NSWindowController

        if let StationWindow = SDVC.window {
            let StationVC = StationWindow.contentViewController as! StationDetailViewController
            StationVC.stationName = selStation.stationName
            StationVC.stationIdStr = selStation.stationKeyStr
            StationVC.loadDetail()
            //            let application = NSApplication.shared
            //            application.runModal(for: poemDetailWindow)
            //            poemDetailWindow.close()

            if SuperManager.UILanguage == .chinese {
                StationWindow.title = "「\(selStation.stationName)」站点信息"
            } else {
                StationWindow.title = "\(selStation.stationNameEn) Info"
            }
            SDVC.showWindow(nil)
        }
    }
}

extension ViewController: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        return ViewController.metroLines.count
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return false
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        return ViewController.metroLines[index]
    }
}

extension ViewController: NSOutlineViewDelegate {
    fileprivate enum CellIdentifiers {
        static let ImgCell = "ImgCellID"
    }

    func outlineViewSelectionDidChange(_ notification: Notification) {
        updateStatus()
    }

    func outlineView(_ outlineView: NSOutlineView, didAdd rowView: NSTableRowView, forRow row: Int) {
        rowView.backgroundColor = .clear
    }

    func outlineView(_ outlineView: NSOutlineView, willDisplayCell cell: Any, for tableColumn: NSTableColumn?, item: Any) {
        let rowNo: Int = outlineView.row(forItem: item)
        var bgColor: NSColor = .blue
        if outlineView.selectedRowIndexes.contains(rowNo) {
            bgColor = ViewController.metroLines[rowNo].primaryColor
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
        text = item?.lineDisplayName() ?? " --- "

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
        wantsLayer = true
        layer?.backgroundColor = NSColor.white.cgColor
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
        if selectionHighlightStyle != .none {
            let selectionRect = NSInsetRect(bounds, 2.5, 2.5)
            NSColor(calibratedWhite: 0.85, alpha: 0.6).setFill()
            let selectionPath = NSBezierPath(rect: selectionRect)
            selectionPath.fill()
        }
    }
}

extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return selectedStations.count
    }
}

extension ViewController: NSTableViewDelegate {
    fileprivate enum StationCellIdentifiers {
        static let StationNameCell = "StationCellID"
        static let AccessibilityCell = "AccessibilityCellID"
        static let ToiletCell = "ToiletCellID"
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var image: NSImage?
        var text: String = ""
        var cellIdentifier: String = ""

        let accessibilityIcon = NSImage(named: "Icons/Accessibility.png")
        let toiletIcon = NSImage(named: "Icons/Toilet.png")

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long

        // 1
        let item = selectedStations[row]

        // 2
        if tableColumn == tableView.tableColumns[0] {
            if SuperManager.UILanguage == .chinese {
                text = item.stationName
            } else {
                text = item.stationNameEn
            }
            cellIdentifier = StationCellIdentifiers.StationNameCell
        } else if tableColumn == tableView.tableColumns[1] {
            image = accessibilityIcon
            cellIdentifier = StationCellIdentifiers.AccessibilityCell
        } else if tableColumn == tableView.tableColumns[2] {
            image = toiletIcon
            cellIdentifier = StationCellIdentifiers.ToiletCell
        }

        // 3
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.imageView?.image = image ?? nil
            return cell
        }
        return nil
    }
}
