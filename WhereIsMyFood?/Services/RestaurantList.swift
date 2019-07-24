//
//  RestaurantList.swift
//  WhereIsMyFood?
//
//  Created by Shreya Randive on 7/23/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import Foundation

struct RestaurantList {
    let name: String
    let imageUrl: URL
    let distance: Double
    let id: String
}

extension RestaurantList {
    init(business: Business) {
        self.name = business.name
        self.id = business.id
        self.imageUrl = business.imageUrl
        self.distance = business.distance / 1609.344
    }
    
    static var distanceFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    var formattedDistance: String? {
        return RestaurantList.distanceFormatter.string(from: distance as NSNumber)
    }
}

