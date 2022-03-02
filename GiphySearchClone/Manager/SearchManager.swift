//
//  SearchManager.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/02/28.
//

import Foundation
import Alamofire
import Combine

class SearchManager {
    private let apiManager = APIManager.shared
    
    func search(_ word: String, offset: Int, limit: Int) -> AnyPublisher<Result<SearchResult, Error>, Never> {
        let params: Parameters = [
            "api_key": "PxXwec0IhSp7FXto3UqLeugCweDdIYN6",
            "q": word,
            "rating": "g",
            "lang": "ko",
            "offset": offset,
            "limit": limit
        ]
        
        return apiManager.request(model: SearchResult.self, type: SearchAPI.search , parameter: params)
            .map { result -> Result<SearchResult, Error> in
                switch result {
                case .success(let value):
                    return .success(value)
                case .failure(let error):
                    return .failure(error)
                }
            }.eraseToAnyPublisher()
    }
}
