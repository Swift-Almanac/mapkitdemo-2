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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Map Demo"
        
        view.addSubview(mapView)
        
        mapView.delegate = self
    }
}

