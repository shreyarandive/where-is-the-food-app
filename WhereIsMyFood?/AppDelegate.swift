//
//  AppDelegate.swift
//  WhereIsMyFood?
//
//  Created by Shreya Randive on 7/15/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import UIKit
import Moya
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()
    let locationService = LocationService()
    let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let moyaService = MoyaProvider<YelpBusinessService.Provider>()
    let jsonDecoder = JSONDecoder()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        locationService.didChangeStatus = { success in
            if success {
                self.locationService.getLocation()
            }
        }
        
        locationService.newLocation = { result in
            switch result {
            case .success(let location):
                //print(location.coordinate.latitude, location.coordinate.longitude)
                self.loadBusinesses(with: location)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        switch locationService.status {
        case .restricted, .notDetermined, .denied:
            gotoLocationPermissionVC()
        default:
            let navigation = myStoryboard.instantiateViewController(withIdentifier: "RestaurantNVC") as? UINavigationController
            window.rootViewController = navigation
            locationService.getLocation()
        }
        window.makeKeyAndVisible()
        return true
    }
    
    func gotoLocationPermissionVC() {
        let locationPermissionVC = myStoryboard.instantiateViewController(withIdentifier: LOCATION_PERMISSION_VC) as? LocationPermissionVC
        window.rootViewController = locationPermissionVC
        locationPermissionVC!.locationService = locationService
    }
    
    private func loadBusinesses(with location: CLLocation) {
        let geocoder = CLGeocoder()
        var address = ""
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let _ = error { return }
            guard let placemark = placemarks?.first else { return }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            let city = placemark.locality ?? ""
            address = streetNumber + streetName + city
            
            self.moyaService.request(.search(location: address, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)) { [weak self] (result) in
                switch result {
                case .success(let response):
                    guard let strongSelf = self else { return }
                    let data = try? strongSelf.jsonDecoder.decode(Data.self, from: response.data)
                    let restaurant = data?.businesses.compactMap(RestaurantList.init).sorted(by: {$0.distance < $1.distance})
                    
                    if let navigation = strongSelf.window.rootViewController as? UINavigationController,
                        let restaurantListVC = navigation.topViewController as? RestaurantNearbyVC {
                        restaurantListVC.restaurants = restaurant ?? []
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

