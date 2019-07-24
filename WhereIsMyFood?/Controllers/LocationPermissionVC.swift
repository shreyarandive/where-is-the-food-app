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
    
    var locationService = LocationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedAllowLocationAccessBtn(_ sender: Any) {
        print("tapped")
        self.locationService.requestLocationAuthorization()
    }
}

