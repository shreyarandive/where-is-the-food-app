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
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        moyaService.request(.search(location: "1300Bryant StSan Francisco", latitude: 29.7604, longitude: 95.3698)) { (result) in
            switch result {
            case .success(let response):
                print(try? JSONSerialization.jsonObject(with: response.data, options: []))
            case .failure(let error):
                print(error)
            }
        }
        
        switch locationService.status {
        case .restricted, .notDetermined, .denied:
            gotoLocationPermissionVC()
        default:
            assertionFailure()
        }
        window.makeKeyAndVisible()
        return true
    }
    
    func gotoLocationPermissionVC() {
        let locationPermissionVC = myStoryboard.instantiateViewController(withIdentifier: LOCATION_PERMISSION_VC) as? LocationPermissionVC
        window.rootViewController = locationPermissionVC
        locationPermissionVC?.locationService = locationService
    }
}

