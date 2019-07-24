//
//  AppDelegate.swift
//  WhereIsMyFood?
//
//  Created by Shreya Randive on 7/15/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()
    let locationService = LocationService()
    let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let moyaService = MoyaProvider<YelpBusinessService.Provider>()
    let jsonDecoder = JSONDecoder()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        switch locationService.status {
        case .restricted, .notDetermined, .denied:
            gotoLocationPermissionVC()
        default:
            let navigation = myStoryboard.instantiateViewController(withIdentifier: "RestaurantNVC") as? UINavigationController
            window.rootViewController = navigation
            loadBusinesses()
        }
        window.makeKeyAndVisible()
        return true
    }
    
    func gotoLocationPermissionVC() {
        let locationPermissionVC = myStoryboard.instantiateViewController(withIdentifier: LOCATION_PERMISSION_VC) as? LocationPermissionVC
        window.rootViewController = locationPermissionVC
        locationPermissionVC?.locationService = locationService
    }
    
    private func loadBusinesses() {
        moyaService.request(.search(location: "1300Bryant StSan Francisco", latitude: 29.7604, longitude: 95.3698)) { (result) in
            switch result {
            case .success(let response):
                let data = try? self.jsonDecoder.decode(Data.self, from: response.data)
                let restaurant = data?.businesses.compactMap(RestaurantList.init)
                if let navigation = self.window.rootViewController as? UINavigationController,
                    let restaurantListVC = navigation.topViewController as? RestaurantNearbyVC {
                    restaurantListVC.restaurants = restaurant ?? []
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

