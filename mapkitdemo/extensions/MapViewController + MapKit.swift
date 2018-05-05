//
//  MapViewController + MapKit.swift
//  mapkitdemo
//
//  Created by Mark Hoath on 3/5/18.
//  Copyright © 2018 Mark Hoath. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        /* This is ONLY called while in foreground
                                        AND
            This is ONLY called if you have set showUserLocation to TRUE
                                         OR
            This is ONLY called if you have set TrackingMode to Follow with Heading.
        */
        
        // So we will CoreLocation didUpdateLocation
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        isZooming = isMapZooming()
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if isZooming {
            mapDiameter = mapView.regionInMeter()
            print("Diameter: \(mapDiameter)")
            isZooming = false
        }
    }
    
    private func isMapZooming() -> Bool {
        let view = self.mapView.subviews[0]
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if recognizer.state == .began || recognizer.state == .ended {
                    return true
                }
            }
        }
        return false
    }
}

extension MKMapView {
    
    func regionInMeter() -> CLLocationDistance {
        
        let eastMapPoint = MKMapPointMake(MKMapRectGetMinX(visibleMapRect), MKMapRectGetMidY(visibleMapRect))
        let westMapPoint = MKMapPointMake(MKMapRectGetMaxX(visibleMapRect), MKMapRectGetMidY(visibleMapRect))
        
        return MKMetersBetweenMapPoints(eastMapPoint, westMapPoint)
    }
}

























