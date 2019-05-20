//
//  StationDetailViewController.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/15.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import MapKit
import SwiftyJSON

class StationDetailViewController: NSViewController {

    
    @objc dynamic var stationName: String = "$STATION_NAME$"
    @objc dynamic var stationNameEn: String = "$STATION_NAME_EN$"
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var stripeA: NSTextField!
    @IBOutlet weak var stripeB: NSTextField!
    @IBOutlet weak var stripeC: NSTextField!
    @IBOutlet weak var stripeD: NSTextField!
    
    
    @IBOutlet weak var startOpText: NSTextField!
    @IBOutlet weak var currentTime: NSTextField!
    @IBOutlet weak var endOpText: NSTextField!
    @IBOutlet weak var isNextDayText: NSTextField!
    
    @IBOutlet weak var lineAndDestSelector: NSPopUpButton!
    
    @IBAction func capabilitiesSelected(_ sender: NSButton) {
        
    }
    
    @IBAction func timeTableOptionSelected(_ sender: NSPopUpButton) {
        
    }
    
    var stations: [Station] = []
    
    var timetables: [JSON] = []
    
    var timetableStrings: [String] = []
    
    var stationIdStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func loadDetail() {
        initStationData(simpleStation: SimpleStation(StationKeyStr: stationIdStr,
                                                     StationName: stationName),
                        stationDetailCompletion: { station in
                            if station != nil {
                                self.stations.append(station!)
                                self.flushUIElement(NSButton())
                                self.loadTimeTable()
                            }
        })
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
        
        for timePiece in timetables {
            let itemTitle = generateSelectTime(timePiece["line"].intValue, timePiece["description"].stringValue)
            timetableStrings.append(itemTitle)
        }
        
        if timetables.count == timetableStrings.count {
            lineAndDestSelector.addItems(withTitles: timetableStrings)
        } else {
            timetables.removeAll()
            timetableStrings.removeAll()
            loadDetail()
        }
    }
    
    @IBAction func flushUIElement(_ sender: NSButton) {
        if (stations.count == 0) {
            return
        }
        
        stationNameEn = stations[0].stationNameEn
        
        let coordinate = CLLocationCoordinate2D(latitude: (stations[0].stationPosition.0), longitude: (stations[0].stationPosition.1))
        
        JZLocationConverter.default.bd09ToGcj02(coordinate, result: setAnnotation(_:))
        
        drawLineColor()
    }
    
    func setAnnotation(_ gcj2Point: CLLocationCoordinate2D) -> Void {
        let region = MKCoordinateRegion(center: gcj2Point,
                                        latitudinalMeters: CLLocationDistance(defaultScaleMeters),
                                        longitudinalMeters: CLLocationDistance(defaultScaleMeters))
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
        
        for metroLine in ViewController.metroLines {
            if lines.contains(metroLine.lineId) {
                colors.append(metroLine.primaryColor)
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
    }
}
