//
//  HeightCalculate.swift
//
//  Created by injun on 2022/03/02.
//

import Foundation
import UIKit

struct HeightCalculate {
    static func calculateImageHeight(image: FixedWidth, width: CGFloat) -> CGFloat {
        let oldWidth = image.width.stringToFloat
        let scaleFactor = width / oldWidth
        let newHeight = image.height.stringToFloat * scaleFactor
        
        return newHeight
    }
}
