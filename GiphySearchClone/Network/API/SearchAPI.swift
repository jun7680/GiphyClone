//
//  SearchAPI.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/02/28.
//

import Foundation
import Alamofire

enum SearchAPI {
    case search
}

extension SearchAPI: EndPoint {
    var url: URL {
        return URL(string: baseURL + version + path)!
    }
    
    var baseURL: String {
        return "https://api.giphy.com"
    }
    
    var version: String {
        return "/v1"
    }
    
    var path: String {
        return "/gifs/search"
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        default: return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default: return URLEncoding.queryString
        }
    }
    
    
}
