//
//  SearchResult.swift
//
//  Created by 옥인준 on 2022/02/28.
//

import Foundation

struct SearchResult: Codable {
    let data: [DataDTO]
    let pagination: PaginationDTO
}
