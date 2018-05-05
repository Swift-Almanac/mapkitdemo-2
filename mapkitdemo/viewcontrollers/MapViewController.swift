//
//  ViewController.swift
//  mapkit
//
//  Created by Mark Hoath on 3/5/18.
//  Copyright © 2018 Mark Hoath. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let mapView = MKMapView(frame: UIScreen.main.bounds)
    
    var mapDiameter: CLLocationDistance = 200.0 // in Meters.
    var isZooming: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Map Demo"
        
        view.addSubview(mapView)
        
        mapView.delegate = self
        
        mapView.mapType = .standard
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true
        
        mapView.showsUserLocation = true
        mapView.showsPointsOfInterest = true
        
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isPitchEnabled = true
        mapView.isRotateEnabled = true
        mapView.isUserInteractionEnabled = true
        mapView.userTrackingMode = .followWithHeading
        
        centerMap()
    }
    
    func centerMap() {
        
        let coordRegion = MKCoordinateRegionMakeWithDistance(MyCoreLocation.shared.currentPosition, mapDiameter, mapDiameter)
        mapView.setRegion(coordRegion, animated: true)
    }
}

