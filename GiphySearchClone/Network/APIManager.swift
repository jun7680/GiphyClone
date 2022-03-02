//
//  APIManager.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/02/28.
//

import Foundation
import Alamofire
import Combine

// API 통신을 위한 클래스
class APIManager {
    static let shared = APIManager()
    
    let session: Session = {
        let session = AF
        
        return session
    }()
    
    // 요청을 위한 request함수
    func request<T>(
        model: T.Type? = nil,
        type: EndPoint,
        parameter: Parameters? = nil
    ) -> AnyPublisher<Result<T, Error>, Never> where T: Codable {
        return session.request(
            type.url,
            method: type.method,
            parameters: parameter,
            encoding: type.encoding,
            headers: type.header
        )
        .cURLDescription { request in
            print("request cURL", request)
        }
        .publishData()
        .result()
        .map { result -> Result<T, Error> in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let value = try decoder.decode(T.self, from: data)
                    return .success(value)
                } catch {
                    return .failure(AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error)))
                }
            case .failure(let error):
                return .failure(error)
            }
        }.eraseToAnyPublisher()
    }
}
