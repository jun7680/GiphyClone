//
//  ResultDTO.swift
//
//  Created by 옥인준 on 2022/02/28.
//

import Foundation

struct DataDTO: Codable {
    let type: String
    let id: String
    let url: String
    let slug: String
    let bitlyGifUrl: String
    let bitlyUrl: String
    let embedUrl: String
    let username: String
    let source: String
    let title: String
    let rating: String
    let contentUrl: String
    let sourcePostUrl: String
    let isSticker: Int
    let importDatetime: String
    let trendingDatetime: String
    let images: ImageDTO
    
    enum CodingKeys: String, CodingKey {
        case type
        case id
        case url
        case slug
        case bitlyGifUrl = "bitly_gif_url"
        case bitlyUrl = "bitly_url"
        case embedUrl = "embed_url"
        case username
        case source
        case title
        case rating
        case contentUrl = "content_url"
        case sourcePostUrl = "source_post_url"
        case isSticker = "is_sticker"
        case importDatetime = "import_datetime"
        case trendingDatetime = "trending_datetime"
        case images
    }
}

struct ImageDTO: Codable {
    let previewGif: PreviewGIF
    let fixedWidth: FixedWidth
    
    enum CodingKeys: String, CodingKey {
        case previewGif = "preview_gif"
        case fixedWidth = "fixed_width"
    }
}

struct FixedWidth: Codable {
    let height: String
    let width: String
    let size: String
    let url: String
    
}

struct PreviewGIF: Codable {
    let height: String
    let width: String
    let size: String
    let url: String
}
