//
//  NSDirectionalEdgeInsets.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 23.03.22.
//

import Foundation
import UIKit

extension NSDirectionalEdgeInsets {
    init(all: CGFloat) {
        self.init(top: all, leading: all, bottom: all, trailing: all)
    }
}
