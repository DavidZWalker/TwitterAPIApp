//
//  Location.swift
//  LocationTestingApp
//
//  Created by David Zack Walker on 04.06.20.
//  Copyright © 2020 David Zack Walker. All rights reserved.
//

import Foundation
import CoreLocation

public class Location {
    public var longitude : Double
    public var latitude : Double
    public var altitude : Double
    public var speed : Double
    
    public var sourceData : CLLocation
    
    public init(fromData: CLLocation) {
        sourceData = fromData
        longitude = fromData.coordinate.longitude
        latitude = fromData.coordinate.latitude
        altitude = fromData.altitude
        speed = fromData.speed
    }
}
