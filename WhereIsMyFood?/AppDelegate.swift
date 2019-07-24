//
//  AppDelegate.swift
//  WhereIsMyFood?
//
//  Created by Shreya Randive on 7/15/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()
    let locationService = LocationService()
    let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
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

