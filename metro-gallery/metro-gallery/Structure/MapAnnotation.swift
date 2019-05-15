//
//  MapAnnotation.swift
//  metro-gallery
//
//  Created by yuetsin on 2019/5/15.
//  Copyright © 2019 yuetsin. All rights reserved.
//

import Cocoa
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    var myCoordinate: CLLocationCoordinate2D
    var stationName: String?
    var stationSubName: String?
    init (myCoordinate: CLLocationCoordinate2D, _ name: String, _ subname: String) {
        self.myCoordinate = myCoordinate
        self.stationName = name
        self.stationSubName = subname
    }
    
    var coordinate: CLLocationCoordinate2D {
        return myCoordinate
    }
    
    var title: String? {
        return stationName
    }
    
    var subtitle: String? {
        return stationSubName
    }
}
