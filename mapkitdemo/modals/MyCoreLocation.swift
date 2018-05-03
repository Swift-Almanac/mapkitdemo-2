//
//  MyCoreLocation.swift
//  mapkit
//
//  Created by Mark Hoath on 3/5/18.
//  Copyright © 2018 Mark Hoath. All rights reserved.
//

import UIKit
import CoreLocation

class MyCoreLocation {
    
    static let shared = MyCoreLocation()
    
    public private(set) var currentLocation: CLLocation
    public private(set) var currentPosition: CLLocationCoordinate2D
    
    private init() {
        currentLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        currentPosition = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }
    
    
    func setCurrentLocation(location: CLLocation) {
        
        currentPosition = location.coordinate
        currentLocation = location
    }
    
}
