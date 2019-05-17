//
//  StationDetailViewController.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/15.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import MapKit

class StationDetailViewController: NSViewController {

    
    @objc dynamic var stationName: String = "$STATION_NAME$"
    @objc dynamic var stationNameEn: String = "$STATION_NAME_EN$"
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var stripeA: NSTextField!
    @IBOutlet weak var stripeB: NSTextField!
    @IBOutlet weak var stripeC: NSTextField!
    @IBOutlet weak var stripeD: NSTextField!
    
    var station: Station?
    
    var stationIdStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func loadDetail() {
        InitStationData(simpleStation: SimpleStation(StationKeyStr: stationIdStr,
                                                     StationName: stationName),
                        stationDetailCompletion: { station in
                            if station != nil {
                                self.station = station
                                self.flushUIElement(NSButton())
                            }
        })
    }
    
    @IBAction func flushUIElement(_ sender: NSButton) {
        if (station != nil) {
            stationNameEn = station?.stationNameEn ?? ""
        }
        let coordinate = CLLocationCoordinate2D(latitude: (station?.stationPosition.0)!, longitude: (station?.stationPosition.1)!)
        
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
                          station!.stationName,
                          station!.stationNameEn))
    }
    
    func drawLineColor() {
        let lines = station?.stationOfLinesId
        var colors: [NSColor] = []
        
        for metroLine in ViewController.metroLines {
            if lines!.contains(metroLine.lineId) {
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
