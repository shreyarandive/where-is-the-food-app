//
//  ViewController.swift
//  WhereIsMyFood?
//
//  Created by Shreya Randive on 7/15/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import UIKit

class RestaurantNearbyVC: UITableViewController {
    
    var restaurants = [RestaurantList]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RESTAURANT_CELL, for: indexPath) as! RestaurantCell
        
        let restaurant = restaurants[indexPath.row]
        cell.configure(with: restaurant)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}
