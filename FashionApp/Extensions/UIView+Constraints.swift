//
//  UIView+Constraints.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 05.04.22.
//

import Foundation
import UIKit

extension UIView {
    func constraintAll(equalTo: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: equalTo.topAnchor),
            self.leftAnchor.constraint(equalTo: equalTo.leftAnchor),
            self.rightAnchor.constraint(equalTo: equalTo.rightAnchor),
            self.bottomAnchor.constraint(equalTo: equalTo.bottomAnchor),
        ])
    }
}
