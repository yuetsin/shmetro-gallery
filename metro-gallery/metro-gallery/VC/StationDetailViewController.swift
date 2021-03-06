//
//  StationDetailViewController.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/15.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import Localize_Swift
import MapKit
import SwiftyJSON

class StationDetailViewController: NSViewController, L11nRefreshDelegate {
    @objc dynamic var stationName: String = "$STATION_NAME$"
    @objc dynamic var stationNameEn: String = "$STATION_NAME_EN$"

    @objc dynamic var startTime: String = ""
    @objc dynamic var endTime: String = ""
    @objc dynamic var currentTime: String = ""
    @objc dynamic var isTomorrow: Bool = false

    @IBOutlet var mapView: MKMapView!

    @IBOutlet var stripeA: NSTextField!
    @IBOutlet var stripeB: NSTextField!
    @IBOutlet var stripeC: NSTextField!
    @IBOutlet var stripeD: NSTextField!

    @IBOutlet var startOpText: NSTextField!
    @IBOutlet var endOpText: NSTextField!
    @IBOutlet var isNextDayText: NSTextField!

    @IBOutlet var lineAndDestSelector: NSPopUpButton!
    @IBOutlet var facilitiesPopUpButton: NSPopUpButton!

    @IBOutlet var generalTabItem: NSTabViewItem!
    @IBOutlet var locationTabItem: NSTabViewItem!
    @IBOutlet var timeTableBox: NSBox!
    @IBOutlet var facilitiesBox: NSBox!
    @IBOutlet var firstTrainLabel: NSTextField!
    @IBOutlet var lastTrainLabel: NSTextField!
    @IBOutlet var nextDayLabel: NSTextField!
    @IBOutlet var toiletRadioButton: NSButton!
    @IBOutlet var elevatorRadioButton: NSButton!
    @IBOutlet var exitRadioButton: NSButtonCell!
    @IBOutlet weak var promptTinyLabel: NSTextField!
    
    var facilityStrings: [String] = []

    @IBAction func capabilitiesSelected(_ sender: NSButton) {
        facilityStrings.removeAll()
        if SuperManager.UILanguage == .chinese {
            switch sender.tag {
            case 43:
                // Toilet Facilities
                for facil in self.stations.first!.toiletPosition.components(separatedBy: "<br />") {
                    facilityStrings += facil.components(separatedBy: CharacterSet(charactersIn: "\r\n,；"))
                }
                //                NSLog(self.stations.first!.toiletPosition)
                break
            case 44:
                // Exit Facilities
                for facil in self.stations.first!.entranceInfo.components(separatedBy: "<br />") {
                    facilityStrings += facil.components(separatedBy: CharacterSet(charactersIn: "\r\n,；"))
                }

                break
            case 45:
                // Elevator Facilities
                for facil in self.stations.first!.elevatorInfo.components(separatedBy: "<br />") {
                    facilityStrings += facil.components(separatedBy: CharacterSet(charactersIn: "\r\n,；"))
                }
                NSLog(self.stations.first!.elevatorInfo)
                break
            default:
                return
            }
        } else {
            switch sender.tag {
            case 43:
                // Toilet Facilities
                for facil in self.stations.first!.toiletPositionEn.components(separatedBy: "<br />") {
                    facilityStrings += facil.components(separatedBy: CharacterSet(charactersIn: "\r\n,；"))
                }
//                NSLog(self.stations.first!.toiletPositionEn)
                break
            case 44:
                // Exit Facilities
                for facil in self.stations.first!.entranceInfoEn.components(separatedBy: "<br />") {
                    facilityStrings += facil.components(separatedBy: CharacterSet(charactersIn: "\r\n,；"))
                }
//                NSLog(self.stations.first!.entranceInfoEn)
                break
            case 45:
                // Elevator Facilities
                for facil in self.stations.first!.elevatorInfoEn.components(separatedBy: "<br />") {
                    facilityStrings += facil.components(separatedBy: CharacterSet(charactersIn: "\r\n,；"))
                }
                break
            default:
                return
            }
        }
        
        facilityStrings.removeAll { (str) -> Bool in
            return str.replacingOccurrences(of: " ", with: "").isEmpty
        }
        facilitiesPopUpButton.removeAllItems()
        facilitiesPopUpButton.addItems(withTitles: facilityStrings)
        adjustWindowSize()
        selectNewItem(NSPopUpButton())
    }
    
    func adjustWindowSize() {
        var frame: NSRect = (self.view.window?.frame)!
        
        frame.origin.y += 23
        
        let width = min(max(Int(facilitiesPopUpButton.fittingSize.width) + 81, 493), 800)
        frame.size = NSSize(width: width, height: 384)
        
        self.view.window?.setFrame(frame, display: true, animate: true)
    }

    @IBAction func selectNewItem(_ sender: NSPopUpButton) {
        if facilitiesPopUpButton.itemArray.count == 0 {
            facilitiesPopUpButton.isHidden = true
            if toiletRadioButton.state == .on {
                promptTinyLabel.stringValue = genLocalizationString(zhHans: "没有卫生间信息",
                    en: "Toilet Info Unavailable")
            } else if elevatorRadioButton.state == .on {
                promptTinyLabel.stringValue = genLocalizationString(zhHans: "没有卫生间信息无障碍电梯信息",
                    en: "Elevator Info Unavailable")
            } else if exitRadioButton.state == .on {
                promptTinyLabel.stringValue = genLocalizationString(zhHans: "正没有出口信息",
                    en: "Entrance Info Unavailable")
            }
        } else {
            facilitiesPopUpButton.isHidden = false
            if toiletRadioButton.state == .on {
                promptTinyLabel.stringValue = genLocalizationString(zhHans: "正在查看第 \(facilitiesPopUpButton.indexOfSelectedItem + 1) 条卫生间信息",
                    en: "Toilet Info #\(facilitiesPopUpButton.indexOfSelectedItem + 1)")
            } else if elevatorRadioButton.state == .on {
                promptTinyLabel.stringValue = genLocalizationString(zhHans: "正在查看第 \(facilitiesPopUpButton.indexOfSelectedItem + 1) 条无障碍电梯信息",
                    en: "Elevator Info #\(facilitiesPopUpButton.indexOfSelectedItem + 1)")
            } else if exitRadioButton.state == .on {
                promptTinyLabel.stringValue = genLocalizationString(zhHans: "正在查看第 \(facilitiesPopUpButton.indexOfSelectedItem + 1) 条出口信息",
                    en: "Entrance Info #\(facilitiesPopUpButton.indexOfSelectedItem + 1)")
            }
        }
    }
    
    func flushUILocalization() {
//        loadDetail()
        renderTimeTable()
        generalTabItem.label = genLocalizationString(zhHans: "一般", en: "General")
        locationTabItem.label = genLocalizationString(zhHans: "位置", en: "Location")
        timeTableBox.title = genLocalizationString(zhHans: "首末班车时间", en: "First and Last Train")
        facilitiesBox.title = genLocalizationString(zhHans: "车站设施", en: "Station Facilities")
        firstTrainLabel.stringValue = genLocalizationString(zhHans: "首班车", en: "First Train")
        lastTrainLabel.stringValue = genLocalizationString(zhHans: "末班车", en: "Last Train")
        nextDayLabel.stringValue = genLocalizationString(zhHans: "次日", en: "Next Day")
        toiletRadioButton.title = genLocalizationString(zhHans: "卫生间", en: "Toilet")
        exitRadioButton.title = genLocalizationString(zhHans: "出口", en: "Exit")
        elevatorRadioButton.title = genLocalizationString(zhHans: "无障碍电梯", en: "Elevator")
    }

    @IBAction func timeTableOptionSelected(_ sender: NSPopUpButton) {
        if timetables.count == 0 {
            return
        }

        let timePiece = timetables[timetableStrings.firstIndex(of: sender.titleOfSelectedItem ?? "") ?? 0]

        startTime = (timePiece.dictionary?["first_time"]?.stringValue ?? "??:??")
            .replacingOccurrences(of: " ", with: "")
        endTime = (timePiece.dictionary?["last_time"]?.stringValue ?? "??:??")
            .replacingOccurrences(of: " ", with: "")

        if startTime.replacingOccurrences(of: " ", with: "").count == 0 {
            if SuperManager.UILanguage == .chinese {
                startTime = "不定"
            } else {
                startTime = "Uncertain"
            }
        }

        if endTime.replacingOccurrences(of: " ", with: "").count == 0 {
            if SuperManager.UILanguage == .chinese {
                endTime = "不定"
            } else {
                endTime = "Uncertain"
            }
        }

        isTomorrow = !endTime.starts(with: "0")
    }

    var stations: [Station] = []

    var timetables: [JSON] = []

    var timetableStrings: [String] = []

    var stationIdStr: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        flushUILocalization()
    }

    func loadDetail() {
        if SuperManager.UILanguage == .chinese {
            initStationData(simpleStation: SimpleStation(StationKeyStr: stationIdStr,
                                                         StationName: stationName),
                            stationDetailCompletion: { station in
                                if station != nil {
                                    self.stations.append(station!)
                                    self.flushUIElement(NSButton())
                                    self.loadTimeTable()
                                }
            })
        } else {
            initStationData(simpleStation: SimpleStation(StationKeyStr: stationIdStr,
                                                         StationName: stationNameEn),
                            stationDetailCompletion: { station in
                                if station != nil {
                                    self.stations.append(station!)
                                    self.flushUIElement(NSButton())
                                    self.loadTimeTable()
                                }
            })
        }
    }

    fileprivate func loadTimeTable() {
        if stations.count == 0 {
            return
        }

        if timetables.count != 0 {
            return
        }

        let stationCode = stations[0].stationCode

        timetables = TimeTableManager.getTimeTableRelatedStation(stationCode)

        renderTimeTable()
    }

    fileprivate func renderTimeTable() {
        lineAndDestSelector.removeAllItems()

        var lineIds: [Int] = []

        for timePiece in timetables {
            let itemTitle = generateSelectTime(timePiece["line"].intValue, timePiece["description"].stringValue)
            timetableStrings.append(itemTitle)
            lineIds.append(timePiece["line"].intValue)
        }

        if timetables.count == timetableStrings.count {
            lineAndDestSelector.addItemsWithSeparator(withTitles: timetableStrings, lineIds)
        } else {
            timetables.removeAll()
            timetableStrings.removeAll()
//            loadDetail()
        }
        timeTableOptionSelected(NSPopUpButton())
    }

    @IBAction func flushUIElement(_ sender: NSButton) {
        if stations.count == 0 {
            return
        }

        let coordinate = CLLocationCoordinate2D(latitude: (stations[0].stationPosition.0), longitude: (stations[0].stationPosition.1))

        JZLocationConverter.default.bd09ToGcj02(coordinate, result: setAnnotation(_:))

        drawLineColor()

//        flushUILocalization()

        if SuperManager.UILanguage == .chinese {
            stationName = stations[0].stationName
            stationNameEn = stations[0].stationNameEn
        } else {
            stationName = stations[0].stationNameEn
            stationNameEn = stations[0].stationName
        }
        
        capabilitiesSelected(toiletRadioButton)
    }

    func setAnnotation(_ gcj2Point: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: gcj2Point,
                                        latitudinalMeters: CLLocationDistance(defaultScaleMeters),
                                        longitudinalMeters: CLLocationDistance(defaultScaleMeters))

        mapView.showsScale = false
        mapView.showsCompass = true
        mapView.showsPointsOfInterest = true
        mapView.setRegion(region, animated: true)
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(
            MapAnnotation(myCoordinate: gcj2Point,
                          stations[0].stationName,
                          stations[0].stationNameEn))
    }

    func drawLineColor() {
        let lines = stations[0].stationOfLinesId
        var colors: [NSColor] = []
        var textColors: [NSColor] = []

        for metroLine in ViewController.metroLines {
            if lines.contains(metroLine.lineId) {
                colors.append(getBorderColor(metroLine.primaryColor))
                textColors.append(getLineTextColor(metroLine.lineId))
            }
        }

        let colorsCount = colors.count

        stripeA.backgroundColor = .clear
        stripeB.backgroundColor = .clear
        stripeC.backgroundColor = .clear
        stripeD.backgroundColor = .clear

        if colorsCount > 0 {
            stripeA.backgroundColor = colors[0]
            if colorsCount > 1 {
                stripeB.backgroundColor = colors[1]
                if colorsCount > 2 {
                    stripeC.backgroundColor = colors[2]
                    if colorsCount > 3 {
                        stripeD.backgroundColor = colors[3]
                    }
                }
            }
        }

        if SuperManager.acessibilityMode {
            if colorsCount > 0 {
                stripeA.stringValue = getMinorIconText(lines[0])
                stripeA.textColor = textColors[0]
                stripeA.sizeToFit()
                if colorsCount > 1 {
                    stripeB.stringValue = getMinorIconText(lines[1])
                    stripeB.textColor = textColors[1]
                    stripeB.sizeToFit()
                    if colorsCount > 2 {
                        stripeC.stringValue = getMinorIconText(lines[2])
                        stripeC.textColor = textColors[2]
                        stripeC.sizeToFit()
                        if colorsCount > 3 {
                            stripeD.stringValue = getMinorIconText(lines[3])
                            stripeD.textColor = textColors[3]
                            stripeD.sizeToFit()
                        }
                    }
                }
            }
        }
    }
}

@objc extension NSPopUpButton {
    func addItemsWithSeparator(withTitles items: [String], _ lineIds: [Int]) {
        var lastLine: String?

        if items.count != lineIds.count {
            NSLog("items and lineIds count mismatch")
        }

        var counter = 0

        for item in items {
            if SuperManager.UILanguage == .chinese {
                let currentLine = item.components(separatedBy: "线")[0]
                if lastLine == nil {
                    lastLine = currentLine
                    addItem(withTitle: item)
                } else {
                    if lastLine == currentLine {
                        addItem(withTitle: item)
                    } else {
                        addItem(withTitle: "---TIMETABLE--ITEM--SEPARATOR---")
                        addItem(withTitle: item)
                        lastLine = currentLine
                    }
                }
            } else {
                let currentLine = item.replacingOccurrences(of: " Inner Ring", with: "")
                    .replacingOccurrences(of: " Outer Ring", with: "")
                    .components(separatedBy: ",")[0]
                if lastLine == nil {
                    lastLine = currentLine
                    addItem(withTitle: item)
                } else {
                    if lastLine == currentLine {
                        addItem(withTitle: item)
                    } else {
                        addItem(withTitle: "---TIMETABLE--ITEM--SEPARATOR---")
                        addItem(withTitle: item)
                        lastLine = currentLine
                    }
                }
            }

            var drawColorSprite: NSImage?
            for line in ViewController.metroLines {
                if line.lineId == lineIds[counter] {
                    drawColorSprite = drawMiniIconByColor(line.primaryColor)
                    break
                }
            }
            if drawColorSprite != nil {
                (menu as! MenuWithSeparator).setItemImage(withTitle: item, image: drawColorSprite!)
            }
            counter += 1
        }
    }
}
