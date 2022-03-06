//
//  PaginationDTO.swift
//
//  Created by 옥인준 on 2022/02/28.
//

import Foundation

struct PaginationDTO: Codable {
    let totalCount: Int
    let count: Int
    let offset: Int
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count
        case offset
    }
}
