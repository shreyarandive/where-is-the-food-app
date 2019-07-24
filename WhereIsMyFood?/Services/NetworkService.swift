//
//  NetworkService.swift
//  WhereIsMyFood?
//
//  Created by Shreya Randive on 7/23/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import Foundation
import Moya

enum YelpBusinessService {
    enum Provider: TargetType {
        case search(location: String, latitude: Double, longitude: Double)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }
        
        var path: String {
            switch self {
            case .search:
                return "/search"
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Task {
            switch self {
            case let .search(location, latitude, longitude):
                return .requestParameters(parameters: ["location": location, "latitude": latitude, "longitude": longitude, "limit": 1], encoding: URLEncoding.queryString)
            }
        }
        
        var headers: [String : String]? {
            return ["Authorization" : "Bearer \(API_KEY)"]
        }
        
        
    }
}

class NetworkService {
    
    
}
