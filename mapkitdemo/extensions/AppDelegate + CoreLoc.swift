//
//  appDelegate + CoreLoc.swift
//  mapkitdemo
//
//  Created by Mark Hoath on 3/5/18.
//  Copyright © 2018 Mark Hoath. All rights reserved.
//

import UIKit
import CoreLocation

let kMaxTimeAge: TimeInterval = 60.0


extension AppDelegate: CLLocationManagerDelegate {
    
    func initLocationServices() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 10.0
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        let topWindow = AppDelegate.topViewController()
        
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            // If authorized when in use
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            // If always authorized
            manager.startUpdatingLocation()
            break
        case .restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            let alert = UIAlertController(title: "", message: "Your Device is Restricted and Can Not Use Location Services. You are unable to Use this App!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            topWindow?.present(alert, animated: true, completion: nil)
            break
        case .denied:
            
            let alert = UIAlertController(title: "Location Manager", message: "To Use This App, we need your Location!", preferredStyle: .alert)
            let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let settingAlertAction = UIAlertAction(title: "Settings", style: .default, handler: { (res) in
                
                if let url = URL(string:UIApplicationOpenSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            })
            alert.addAction(cancelAlertAction)
            alert.addAction(settingAlertAction)
            
            topWindow?.present(alert, animated: true, completion: nil)
            
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let newLocation = locations.last else {
            print ("Bad Location")
            return
        }
        
        let locationAge: TimeInterval = -(newLocation.timestamp.timeIntervalSinceNow)
        var oldLocation: CLLocation?
        
        // If the age of the location is too old, ignore the update.
        
        if locationAge > kMaxTimeAge {
            print ("Location Update Too Old")
            return
        }
        
        // if Horizontal Accuracy is Bad then ignore the Coordinate
        
        if newLocation.horizontalAccuracy < 0 {
            print ("Invalid location accuracy. Rejected")
        }
        
        if newLocation.horizontalAccuracy > 50.0 {
            print ("Horizontal Accuracy too Broad")
        }
        
        // Set the last OldLocation
        
        if locations.count > 1 {
            oldLocation = (locations[locations.count-1])
        } else {
            oldLocation = nil
        }
                
        // Now we have an accurate coordinate !
        
        MyCoreLocation.shared.setCurrentLocation(location: newLocation)
        
    }
    
    func startUpdatingLocation() {
        let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if status == .denied {
            print("Location Services are disabled in settings")
        } else {
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.startUpdatingLocation()
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(saveLocation), userInfo: nil, repeats: true)
        }
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        if (timer?.isValid)! {
            timer?.invalidate()
        }
    }
    
    @objc func saveLocation() {
        // Write the Current Location to the Database
        print ("Lat: \(MyCoreLocation.shared.currentPosition.latitude), Lon: \(MyCoreLocation.shared.currentPosition.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("Location Manager Failed with Error \(error)")
    }
}
