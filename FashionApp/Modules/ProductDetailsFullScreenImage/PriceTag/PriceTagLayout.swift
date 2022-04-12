//
//  PriceTagLayout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 11.04.22.
//

import Foundation
import UIKit

protocol PriceTagLayoutable {
    static func apply(
        view: UIView,
        button: UIButton,
        labelShape: ShapedView,
        nameLabel: UILabel,
        priceLabel: UILabel
    )
}

class PriceTagLayout: PriceTagLayoutable {
    class func apply(
        view: UIView,
        button: UIButton,
        labelShape: ShapedView,
        nameLabel: UILabel,
        priceLabel: UILabel
    ) {
        
        UIView.disableAutoresizingMaskIntoConstraints(views: [
            button,
            priceLabel,
            labelShape,
            nameLabel
        ])
        
        let spaceBetweenButtonAndLabel: CGFloat = 8
        
        labelShape.layoutMargins = .zero
        nameLabel.layoutMargins = .init(top: -10, left: -15, bottom: 0, right: -15)
        priceLabel.layoutMargins = .init(top: 0, left: -5, bottom: -3, right: -10)
        
        NSLayoutConstraint.activate([
            labelShape.leftAnchor.constraint(equalTo: button.rightAnchor, constant: spaceBetweenButtonAndLabel),
            nameLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.layoutMarginsGuide.topAnchor.constraint(equalTo: labelShape.topAnchor),
            nameLabel.layoutMarginsGuide.leftAnchor.constraint(equalTo: labelShape.leftAnchor),
            nameLabel.layoutMarginsGuide.rightAnchor.constraint(equalTo: labelShape.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.layoutMarginsGuide.topAnchor.constraint(equalTo: nameLabel.layoutMarginsGuide.bottomAnchor),
            priceLabel.layoutMarginsGuide.rightAnchor.constraint(equalTo: nameLabel.layoutMarginsGuide.rightAnchor, constant: -20),
            priceLabel.layoutMarginsGuide.bottomAnchor.constraint(equalTo: labelShape.layoutMarginsGuide.bottomAnchor),
        
        ])
    }
}
