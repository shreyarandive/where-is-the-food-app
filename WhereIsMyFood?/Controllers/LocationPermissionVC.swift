//
//  ViewController.swift
//  WhereIsMyFood?
//
//  Created by Shreya Randive on 7/15/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import UIKit

class LocationPermissionVC: UIViewController {

    @IBOutlet weak var allowLocationAccessBtn: RoundedButton!
    @IBOutlet weak var denyLocationAccessBtn: UIButton!
    
    var locationService: LocationService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationService?.didChangeStatus = { [weak self] success in
            if success {
                self?.locationService?.getLocation()
            }
        }
        
        locationService?.newLocation = { [weak self] result in
            switch result {
            case .success(let location):
                print(location)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    @IBAction func tappedAllowLocationAccessBtn(_ sender: Any) {
        print("tapped")
        self.locationService?.requestLocationAuthorization()
    }
}

