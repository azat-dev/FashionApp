//
//  Fonts.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 16.03.2022.
//

import Foundation
import UIKit

typealias FontFileName = String

protocol Font {
    var rawValue: FontFileName { get }
    func preferred(with: UIFont.TextStyle) -> UIFont
}

extension Font {
    func preferred(with style: UIFont.TextStyle) -> UIFont {
        UIFont.preferredFont(name: self.rawValue, forTextStyle: style)
    }
}

class Fonts {
    enum RedHatDisplay: FontFileName, Font {
        case regular = "RedHatDisplay-Regular"
        case medium = "RedHatDisplay-Medium"
        case semiBold = "RedHatDisplay-SemiBold"
        case bold = "RedHatDisplay-Bold"
    }
}
