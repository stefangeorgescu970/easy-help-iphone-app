//
//  LocationUtils.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 30/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import CoreLocation

class LocationUtils: NSObject {
    static let sharedInstance = LocationUtils()
    
    private let locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    
    private override init() {}
    
    func requestAuth() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startReceivingLocationChanges() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedWhenInUse {
            // User has not authorized access to location information.
            return
        }
        // Do not start services that aren't available.
        if !CLLocationManager.locationServicesEnabled() {
            // Location services is not available.
            return
        }
        // Configure and start the service.
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100.0  // In meters.
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func stopReceivingLocationChanges() {
        locationManager.stopUpdatingLocation()
    }
    
}

extension LocationUtils: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last!
    }
}
