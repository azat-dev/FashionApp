//
//  ProductCell+Styles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

typealias AsyncImageViewAligned = AsyncImageView<UIImageViewAligned>

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
        removeLoadingAnimation(view: nameLabel)
        
        nameLabel.textAlignment = .left
        nameLabel.font = Self.nameLabelFont
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .black
    }
    
    static func apply(brandLabel: UILabel) {
        removeLoadingAnimation(view: brandLabel)
        
        brandLabel.textColor = UIColor(named: "ColorBrandLabel")
        brandLabel.textAlignment = .left
        brandLabel.font = Self.brandLabelFont
        brandLabel.backgroundColor = .clear
        
    }
    
    static func apply(priceLabel: UILabel) {
        removeLoadingAnimation(view: priceLabel)
        
        priceLabel.textAlignment = .left
        priceLabel.font = Self.priceLabelFont
        priceLabel.backgroundColor = .clear
        priceLabel.textColor = .black
    }

    static func getLoadingAnimationLayer(view: UIView) -> CALayer? {
        return (view.layer.sublayers ?? []).first { sublayer in
            guard let layer = sublayer as? CAGradientLayer else {
                return false
            }
            
            return layer.animation(forKey: "loadingAnimation") != nil
        }
    }
    
    static func removeLoadingAnimation(view: UIView) {
        guard let loadingLayer = getLoadingAnimationLayer(view: view) else {
            return
        }

        loadingLayer.removeFromSuperlayer()
    }
    
    static func getRect(size: CGSize, angle: CGFloat) -> CGSize {
        return CGSize(
            width: size.height * cos(angle.radians) + size.width * sin(angle.radians),
            height: size.height * sin(angle.radians) + size.width * cos(angle.radians)
        )
    }
    
    static func addLoadingAnimation(view: UILabel) {
        guard getLoadingAnimationLayer(view: view) == nil else {
            return
        }
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.bounds = view.bounds
        gradientLayer.anchorPoint = .init(x: 0, y: 0)
        gradientLayer.startPoint = .init(x: 1, y: 0)
        gradientLayer.endPoint = .init(x: 0, y: 1)
        gradientLayer.locations = [
            0.2,
            0.6,
            1
        ]
        gradientLayer.colors = [
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(0.5).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor,
        ]

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 1
        animation.fromValue = -view.bounds.width
        animation.toValue = view.bounds.width
        animation.repeatCount = Float.infinity

        gradientLayer.add(animation, forKey: "loadingAnimation")
        view.layer.addSublayer(gradientLayer)
    }
    
    static func apply(loadingLabel: UILabel) {
        loadingLabel.textColor = .clear
        loadingLabel.backgroundColor = UIColor(named: "ColorProductCellBackground")
        loadingLabel.layer.cornerRadius = 5
        loadingLabel.clipsToBounds = true
        
        addLoadingAnimation(view: loadingLabel)
//        let animation = CABasicAnimation(keyPath: "opacity")
//
//        animation.fromValue = 0.2
//        animation.toValue = 0.9
//        animation.duration = 1
//        animation.repeatCount = .infinity
//        animation.autoreverses = true
//
//        loadingLabel.layer.add(animation, forKey: "loadingAnimation")
    }
    
    static func apply(priceLabelLoading priceLabel: UILabel) {
        apply(priceLabel: priceLabel)
        apply(loadingLabel: priceLabel)
    }
    
    static func apply(nameLabelLoading nameLabel: UILabel) {
        apply(nameLabel: nameLabel)
        apply(loadingLabel: nameLabel)
    }
    
    static func apply(brandLabelLoading brandLabel: UILabel) {
        apply(brandLabel: brandLabel)
        apply(loadingLabel: brandLabel)
    }
}
