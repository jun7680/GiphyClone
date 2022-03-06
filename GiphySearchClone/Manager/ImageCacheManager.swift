//
//  ImageCacheManager.swift
//
//  Created by 옥인준 on 2022/03/02.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
