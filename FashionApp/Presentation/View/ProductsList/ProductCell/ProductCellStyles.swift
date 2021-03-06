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
    static func apply(nameLabelLoading: UILabel)
    static func apply(brandLabel: UILabel)
    static func apply(brandLabelLoading: UILabel)
    static func apply(priceLabel: UILabel)
    static func apply(priceLabelLoading: UILabel)
    static func apply(imageShadow: ShadowView)
    static func apply(imageContainer: ShapedView)
    static func apply(asyncImageView: AsyncImageViewAligned)
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
                    roundedRect: $0.bounds,
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
                        x: view.bounds.midX - width / 2,
                        y: view.bounds.maxY - 10
                    ),
                    size: CGSize(
                        width: width,
                        height: view.bounds.height * 0.05
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
    
    static func apply(asyncImageView: AsyncImageViewAligned) {
        asyncImageView.imageView.contentMode = .scaleAspectFit
        asyncImageView.imageView.alignBottom = true
    }
    
    static func apply(nameLabel: UILabel) {
        GlobalStyles.apply(viewDisabledLoading: nameLabel)
        
        nameLabel.textAlignment = .left
        nameLabel.font = Self.nameLabelFont
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .black
    }
    
    static func apply(brandLabel: UILabel) {
        GlobalStyles.apply(viewDisabledLoading: brandLabel)
        
        brandLabel.textColor = UIColor(named: "ColorBrandLabel")
        brandLabel.textAlignment = .left
        brandLabel.font = Self.brandLabelFont
        brandLabel.backgroundColor = .clear
        
    }
    
    static func apply(priceLabel: UILabel) {
        GlobalStyles.apply(viewDisabledLoading: priceLabel)
        
        priceLabel.textAlignment = .left
        priceLabel.font = Self.priceLabelFont
        priceLabel.backgroundColor = .clear
        priceLabel.textColor = .black
    }

    static func getRect(size: CGSize, angle: CGFloat) -> CGSize {
        return CGSize(
            width: size.height * cos(angle.radians) + size.width * sin(angle.radians),
            height: size.height * sin(angle.radians) + size.width * cos(angle.radians)
        )
    }

    static func apply(priceLabelLoading priceLabel: UILabel) {
        apply(priceLabel: priceLabel)
        GlobalStyles.apply(loadingLabel: priceLabel)
    }
    
    static func apply(nameLabelLoading nameLabel: UILabel) {
        apply(nameLabel: nameLabel)
        GlobalStyles.apply(loadingLabel: nameLabel)
    }
    
    static func apply(brandLabelLoading brandLabel: UILabel) {
        apply(brandLabel: brandLabel)
        GlobalStyles.apply(loadingLabel: brandLabel)
    }
}
