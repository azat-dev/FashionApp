//
//  ProductCell+Styles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit

protocol ProductCellStylable {
    static func style(shapedImageView: ShapedImageView)
    static func style(nameLabel: UILabel)
    static func style(brandLabel: UILabel)
    static func style(priceLabel: UILabel)
}

class RoundedRectShapeDelegate: ShapeDelegate {
    func shape(view containerView: UIView) -> CGPath? {
        CGPath(
            roundedRect: containerView.frame,
            cornerWidth: 8,
            cornerHeight: 8,
            transform: nil
        )
    }
}
 
extension ProductCell: ProductCellStylable {
    static let roundedShapeDelegate = RoundedRectShapeDelegate()
    
    static var nameLabelFont: UIFont {
        .preferredFont(name: FontRedHatDisplay.medium.rawValue, forTextStyle: .headline)
    }
    
    static var brandLabelFont: UIFont {
        .preferredFont(name: FontRedHatDisplay.bold.rawValue, forTextStyle: .footnote)
    }
    
    static var priceLabelFont: UIFont {
        .preferredFont(name: FontRedHatDisplay.regular.rawValue, forTextStyle: .headline)
    }
    
    static func style(shapedImageView: ShapedImageView) {
        shapedImageView.imageView.contentMode = .scaleAspectFit
        shapedImageView.imageView.backgroundColor = UIColor(named: "ColorProductCellBackground")
        shapedImageView.translatesAutoresizingMaskIntoConstraints = false
        shapedImageView.delegateShape = Self.roundedShapeDelegate
        
        let shadowColor = UIColor(red: 0.094, green: 0.153, blue: 0.294, alpha: 1).cgColor
        
        shapedImageView.shadows = [
            ShadowView.ShadowParams(
                color: shadowColor,
                opacity: 0.03,
                radius: 24,
                offset: CGSize(width: 0, height: 8)
            ),
            ShadowView.ShadowParams(
                color: shadowColor,
                opacity: 0.08,
                radius: 12,
                offset: CGSize(width: 0, height: 6)
            ),
        ]
    }
    
    static func style(nameLabel: UILabel) {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        nameLabel.font = Self.nameLabelFont
    }
    
    static func style(brandLabel: UILabel) {
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.textColor = UIColor(named: "ColorBrandLabel")
        brandLabel.textAlignment = .left
        brandLabel.font = Self.brandLabelFont
    }
    
    static func style(priceLabel: UILabel) {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .left
        priceLabel.font = Self.priceLabelFont
    }
}
