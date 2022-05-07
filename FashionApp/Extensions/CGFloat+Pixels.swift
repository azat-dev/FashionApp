//
//  CGFloat+Pixels.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 06.05.22.
//

import Foundation
import UIKit

extension CGFloat {
    var pixels: Int {
        return Int(self * UIScreen.main.scale)
    }
}
