//
//  RestaurantNearbyTableView.swift
//  WhereIsMyFood?
//
//  Created by Shreya Randive on 7/24/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewController {

    var restaurants = [RestaurantList]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RESTAURANT_CELL, for: indexPath) as! RestaurantTableViewCell
        
        let restaurant = restaurants[indexPath.row]
    }
}
