//
//  LocationService.swift
//  WhereIsMyFood?
//
//  Created by Shreya Randive on 7/23/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import Foundation
import CoreLocation

enum Result<Template> {
    case success(Template)
    case failure(Error)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    private let locationManager : CLLocationManager
    
    init(locationManager: CLLocationManager = .init()) {
        self.locationManager = locationManager
        super.init()
        locationManager.delegate = self
    }
    
    var newLocation: ((Result<CLLocation>) -> Void)?
    var didChangeStatus: ((Bool) -> Void)?
    var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted, .notDetermined:
            didChangeStatus?(false)
        default:
            didChangeStatus?(true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.sorted(by: {$0.timestamp > $1.timestamp}).first {
            newLocation?(.success(location))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        newLocation?(.failure(error))
    }
}
