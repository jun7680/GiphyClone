//
//  SearchEndPoint.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/02/28.
//

import Foundation
import Alamofire

protocol EndPoint {
    var url: URL { get }
    var baseURL: String { get }
    var version: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}
