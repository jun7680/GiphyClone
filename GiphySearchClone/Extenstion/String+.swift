//
//  String+.swift
//  WatchaAssignment
//
//  Created by 옥인준 on 2022/03/01.
//

import Foundation
import UIKit

extension String {
    var stringToFloat: CGFloat {
        return CGFloat((self as NSString).floatValue)
    }
}
