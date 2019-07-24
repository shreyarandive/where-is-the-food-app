//
//  Business.swift
//  WhereIsMyFood?
//
//  Created by Shreya Randive on 7/23/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import Foundation

struct Data: Codable {
    let businesses: [Business]
}

struct Business: Codable {
    let id: String
    let name: String
    let imageUrl: URL
    let distance: Double
}
