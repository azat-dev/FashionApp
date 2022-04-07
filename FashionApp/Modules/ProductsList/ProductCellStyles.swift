//
//  ProductCell+Styles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

protocol ProductCellStylable {
    static func apply(nameLabel: UILabel)
    static func apply(brandLabel: UILabel)
    static func apply(priceLabel: UILabel)
    static func apply(imageShadow: ShadowView)
    static func apply(imageContainer: ShapedView)
    static func apply(imageView: UIImageViewAligned)
}

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
    
    class var cornerRadius: CGFloat {
        12
    }
    
    class var imageShape: ShapeCallback {
        get {
            let callback: ShapeCallback = {
                CGPath(
                    roundedRect: $0.frame,
                    cornerWidth: cornerRadius,
                    cornerHeight: cornerRadius,
                    transform: nil
                )
            }
            
            return callback
        }
    }
    
    class var shadowShape: ShapeCallback {
        get {
            let callback: ShapeCallback = { view in
                let width = view.frame.width * 0.6
                
                let rect = CGRect(
                    origin: CGPoint(
                        x: view.frame.midX - width / 2,
                        y: view.frame.maxY - 10
                    ),
                    size: CGSize(
                        width: width,
                        height: view.frame.height * 0.05
                    )
                )
                
                
                return CGPath(
                    roundedRect: rect,
                    cornerWidth: cornerRadius,
                    cornerHeight: cornerRadius,
                    transform: nil
                )
            }
            
            return callback
        }
    }
    
    static func apply(imageShadow: ShadowView) {
        let shadowColor = UIColor(red: 0.094, green: 0.153, blue: 0.3, alpha: 1).cgColor
        
        imageShadow.shape = shadowShape
        imageShadow.shadows = [
            ShadowView.ShadowParams(
                color: shadowColor,
                opacity: 0.4,
                radius: 15,
                offset: CGSize(width: 0, height: 8)
            ),
            //            ShadowView.ShadowParams(
            //                color: shadowColor,
            //                opacity: 0.1,
            //                radius: 12,
            //                offset: CGSize(width: 0, height: 6)
            //            ),
        ]
    }
    
    static func apply(imageContainer: ShapedView) {
        imageContainer.backgroundColor = UIColor(named: "ColorProductCellBackground")
        imageContainer.shape = imageShape
    }
    
    static func apply(imageView: UIImageViewAligned) {
        imageView.contentMode = .scaleAspectFit
        imageView.alignBottom = true
    }
    
    static func apply(nameLabel: UILabel) {
        nameLabel.textAlignment = .left
        nameLabel.font = Self.nameLabelFont
    }
    
    static func apply(brandLabel: UILabel) {
        brandLabel.textColor = UIColor(named: "ColorBrandLabel")
        brandLabel.textAlignment = .left
        brandLabel.font = Self.brandLabelFont
    }
    
    static func apply(priceLabel: UILabel) {
        priceLabel.textAlignment = .left
        priceLabel.font = Self.priceLabelFont
    }
}
