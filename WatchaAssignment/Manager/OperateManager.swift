//
//  APIManager.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/02/28.
//

import Foundation

class OperateManger {
    static let shared = OperateManger()

    lazy var searchManager = SearchManager()
}
