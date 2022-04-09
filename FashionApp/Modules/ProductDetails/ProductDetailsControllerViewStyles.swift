//
//  ProductDetailsControllerView+Styles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

protocol ProductDetailsViewStylable {
    static func apply(imageShadow: ShadowView)
    static func apply(imageContainer: ShapedView)
    static func apply(imageView: UIImageViewAligned)
    static func apply(scrollView: UIScrollView)
    static func apply(titleLabel: UILabel)
    static func apply(brandLabel: UILabel)
    static func apply(descriptionLabel: UILabel)
    static func apply(cartButton: UIButton)
    static func apply(imageDescriptionButton: UIButton)
    static func apply(backButton: UIButton)
    static func apply(contentView: UIView)
}

// MARK: - Style Views
class ProductDetailsViewControllerStyles: ProductDetailsViewStylable {
    class var cornerRadius: CGFloat {
        15
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
    
    class var imageShadowShape: ShapeCallback {
        get {
            let callback: ShapeCallback = { view in
                let width = view.frame.width * 0.6
                let height =  view.frame.height * 0.05
                
                let rect = CGRect(
                    origin: CGPoint(
                        x: view.frame.midX - width / 2,
                        y: view.frame.maxY - height * 0.9
                    ),
                    size: CGSize(
                        width: width,
                        height: height
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
    
    class func apply(imageShadow: ShadowView) {
        imageShadow.shape = imageShadowShape
        
        let shadowColor = UIColor(red: 0.094, green: 0.153, blue: 0.3, alpha: 1).cgColor
        imageShadow.shadows = [
            ShadowView.ShadowParams(
                color: shadowColor,
                opacity: 0.25,
                radius: 15,
                offset: CGSize(width: 0, height: 8)
            ),
        ]
    }
    
    class func apply(imageContainer: ShapedView) {
        imageContainer.backgroundColor = UIColor(named: "ColorProductCellBackground")
        imageContainer.shape = imageShape
    }
    
    class func apply(imageView: UIImageViewAligned) {
        imageView.contentMode = .scaleAspectFit
        imageView.alignBottom = true
    }
    
    class func apply(scrollView: UIScrollView) {
        scrollView.backgroundColor = UIColor.systemBackground
    }
    
    class func apply(contentView: UIView) {
        
    }
    
    class func apply(titleLabel: UILabel) {
        titleLabel.font = Fonts.RedHatDisplay.medium.preferred(with: .largeTitle)
        titleLabel.textAlignment = .left
    }
    
    class func apply(brandLabel: UILabel) {
        brandLabel.font = Fonts.RedHatDisplay.medium.preferred(with: .body)
        brandLabel.textAlignment = .left
        brandLabel.textColor = UIColor(named: "ColorBrandLabel")
    }
    
    class func apply(descriptionLabel: UILabel) {
        descriptionLabel.font = Fonts.RedHatDisplay.medium.preferred(with: .subheadline)
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor(named: "ColorProductDescription")
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
    }
    
    class func apply(cartButton: UIButton) {
        let cartButtonCornerRadius: CGFloat = 12
        let cartButtonImage = UIImage(systemName: "cart")
        let cartButtonBackgroundColor = UIColor(named: "ColorProductCellBackground")
        let cartButtonFont = Fonts.RedHatDisplay.medium.preferred(with: .body)
        let cartButtonForegroundColor = UIColor.black
        
        let cartButtonImageInset: CGFloat = 10
        let cartButtonContentInsets = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        
        guard #available(iOS 15, *) else {

            cartButton.tintColor = cartButtonForegroundColor
            cartButton.backgroundColor = cartButtonBackgroundColor
            cartButton.setTitle("Add to cart", for: .normal)
            cartButton.setImage(cartButtonImage, for: .normal)
            cartButton.contentEdgeInsets = cartButtonContentInsets
            cartButton.titleLabel?.font = cartButtonFont
            cartButton.layer.cornerRadius = cartButtonCornerRadius
            return
        }
        
        var cartButtonConfig = UIButton.Configuration.filled();
        
        var attString = AttributedString("Add to cart")
        attString.font = cartButtonFont
        
        cartButtonConfig.attributedTitle = attString
        cartButtonConfig.baseForegroundColor = UIColor.black
        cartButtonConfig.baseBackgroundColor = cartButtonBackgroundColor
        cartButtonConfig.cornerStyle = .fixed
        cartButtonConfig.background.cornerRadius = cartButtonCornerRadius
        
        cartButtonConfig.contentInsets.top = cartButtonContentInsets.top
        cartButtonConfig.contentInsets.bottom = cartButtonContentInsets.bottom
        cartButtonConfig.contentInsets.leading = cartButtonContentInsets.left
        cartButtonConfig.contentInsets.trailing = cartButtonContentInsets.right
        
        cartButtonConfig.image = cartButtonImage
        cartButtonConfig.imagePadding = cartButtonImageInset
        cartButton.configuration = cartButtonConfig
    }
    
    class func apply(imageDescriptionButton: UIButton) {
        if #available(iOS 15, *) {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
            let image = UIImage(systemName: "viewfinder", withConfiguration: imageConfig)
            
            
            var imageDescriptionButtonConfig = UIButton.Configuration.bordered()
            imageDescriptionButtonConfig.image = image
            imageDescriptionButtonConfig.baseBackgroundColor = UIColor(named: "ColorImageDescriptionButtonBackground")
            imageDescriptionButtonConfig.baseForegroundColor = UIColor(named: "ColorImageDescriptionButtonForeground")
            imageDescriptionButtonConfig.cornerStyle = .capsule
            imageDescriptionButtonConfig.contentInsets = NSDirectionalEdgeInsets(all: 16)
            imageDescriptionButtonConfig.background.strokeColor = UIColor(named: "ColorImageDescriptionButtonBorder")
            imageDescriptionButtonConfig.background.strokeWidth = 1
            
            imageDescriptionButton.configuration = imageDescriptionButtonConfig
        }
    }
    
    class func apply(backButton: UIButton) {
        
        let imageConfig = UIImage.SymbolConfiguration(
            pointSize: 16,
            weight: .medium
        )
        let image = UIImage(systemName: "arrow.left")?.withConfiguration(imageConfig)
        
        guard #available(iOS 15, *) else {
            backButton.setImage(image, for: .normal)
            backButton.tintColor = .black
            return
        }
        
        var backButtonConfig = UIButton.Configuration.plain()
        backButtonConfig.baseForegroundColor = .black
        backButtonConfig.image = image
        
        backButton.configuration = backButtonConfig
    }
}
