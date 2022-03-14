//
//  test.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 14.03.2022.
//

import Foundation
import UIKit

func applyShadow(view: UIView, path: CGPath) {

    let layer0 = CALayer()

    layer0.shadowPath = path
    layer0.shadowColor = UIColor(red: 0.094, green: 0.153, blue: 0.294, alpha: 0.08).cgColor
    layer0.shadowOpacity = 1
    layer0.shadowRadius = 24
    layer0.shadowOffset = CGSize(width: 0, height: 8)
    layer0.bounds = view.bounds
    layer0.position = view.center

    view.layer.addSublayer(layer0)

    let layer1 = CALayer()

    layer1.shadowPath = path
    layer1.shadowColor = UIColor(red: 0.094, green: 0.153, blue: 0.294, alpha: 0.12).cgColor
    layer1.shadowOpacity = 1
    layer1.shadowRadius = 12
    layer1.shadowOffset = CGSize(width: 0, height: 6)
    layer1.bounds = view.bounds
    layer1.position = view.center

    view.layer.addSublayer(layer1)
}
