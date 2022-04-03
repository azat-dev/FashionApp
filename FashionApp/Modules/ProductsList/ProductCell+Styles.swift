//
//  ProductCell+Styles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit
 
class ProductCellStyles: ProductCellStylable {
    class var nameLabelFont: UIFont {
        Fonts.RedHatDisplay.medium.preferred(with: .headline)
    }
    
    class var brandLabelFont: UIFont {
        Fonts.RedHatDisplay.bold.preferred(with: .footnote)
    }
    
    class var priceLabelFont: UIFont {
        Fonts.RedHatDisplay.regular.preferred(with: .headline)
    }
    
    class var imageShape: ShapeCallback {
        get {
            let callback: ShapeCallback = {
               CGPath(
                roundedRect: $0.frame,
                   cornerWidth: 8,
                   cornerHeight: 8,
                   transform: nil
               )
           }
            
            return callback
        }
    }
    
    static func apply(shapedImageView: ShapedImageView) {
        shapedImageView.imageView.contentMode = .scaleAspectFit
        shapedImageView.imageView.backgroundColor = UIColor(named: "ColorProductCellBackground")
        shapedImageView.translatesAutoresizingMaskIntoConstraints = false
        shapedImageView.imageShape = imageShape
        
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
    
    static func apply(nameLabel: UILabel) {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        nameLabel.font = Self.nameLabelFont
    }
    
    static func apply(brandLabel: UILabel) {
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.textColor = UIColor(named: "ColorBrandLabel")
        brandLabel.textAlignment = .left
        brandLabel.font = Self.brandLabelFont
    }
    
    static func apply(priceLabel: UILabel) {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .left
        priceLabel.font = Self.priceLabelFont
    }
}
