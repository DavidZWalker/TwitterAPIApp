//
//  LocationService.swift
//  LocationTestingApp
//
//  Created by David Zack Walker on 04.06.20.
//  Copyright © 2020 David Zack Walker. All rights reserved.
//

import Foundation
import CoreLocation

public class LocationService : NSObject, CLLocationManagerDelegate {
    public static let shared = LocationService()
    private let locationManager = CLLocationManager()
    private let defaultAccuracy = 100
    private var lastLocation = CLLocation()
    private(set) var updateMode = LocationUpdateModes.OneTime
    var locationUpdateCallback : (Location) -> Void = { _ in }
    
    private override init() {
        super.init()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.desiredAccuracy = CLLocationAccuracy(defaultAccuracy)
            locationManager.delegate = self
        }
    }
    
    public func updateLocation() {
        if (updateMode == .OneTime) {
            locationManager.requestLocation()
        }
    }
    
    public func setUpdateMode(mode: LocationUpdateModes) {
        self.updateMode = mode
        if (self.updateMode == .Continuous) {
            self.locationManager.startUpdatingLocation()
        }
        else {
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    // MARK: - Location Manager functions
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lastLocation = location
        }
        
        locationUpdateCallback(Location(fromData: lastLocation))
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
