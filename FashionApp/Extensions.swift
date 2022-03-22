//
//  Extensions.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 16.03.2022.
//

import Foundation
import UIKit

extension CGFloat {
    var radians: CGFloat {
        self * .pi / 180.0
    }
}

extension UIFont {
    static func preferredFont(forTextStyle style: TextStyle, weight: Weight) -> UIFont {
        
        let metrics = UIFontMetrics(forTextStyle: style)
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: descriptor.pointSize, weight: weight)
        
        return metrics.scaledFont(for: font)
    }
    
    static func preferredFont(name: String, forTextStyle style: TextStyle) -> UIFont {
        
        let metrics = UIFontMetrics(forTextStyle: style)
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont(name: name, size: descriptor.pointSize)!
        
        return metrics.scaledFont(for: font)
    }
}

extension NSDirectionalEdgeInsets {
    init(all: CGFloat) {
        self.init(top: all, leading: all, bottom: all, trailing: all)
    }
}
