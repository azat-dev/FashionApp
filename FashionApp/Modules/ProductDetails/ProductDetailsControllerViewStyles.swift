//
//  ProductDetailsControllerView+Styles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit

protocol ProductDetailsViewStylable {
    static func apply(imageShape: ShapedView)
    static func apply(imageView: UIImageView)
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
    class func apply(imageShape: ShapedView) {
        imageShape.backgroundColor = UIColor(named: "ColorProductCellBackground")
        imageShape.shape = { view in
            CGPath(
                roundedRect: view.bounds,
                cornerWidth: 20,
                cornerHeight: 20,
                transform: nil
            )
        }
    }
    
    class func apply(imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFit
    }
    
    class func apply(scrollView: UIScrollView) {
        
        scrollView.backgroundColor = UIColor.systemBackground
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
        
        if #available(iOS 15, *) {
            var cartButtonConfig = UIButton.Configuration.filled();
            
            var attString = AttributedString.init("Add to cart")
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
            
        } else {
            
            cartButton.tintColor = cartButtonForegroundColor
            cartButton.backgroundColor = cartButtonBackgroundColor
            cartButton.setTitle("Add to cart", for: .normal)
            cartButton.setImage(cartButtonImage, for: .normal)
            cartButton.contentEdgeInsets = cartButtonContentInsets
            cartButton.titleLabel?.font = cartButtonFont
            cartButton.layer.cornerRadius = cartButtonCornerRadius
        }
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
        
        let backButtonImageConfig = UIImage.SymbolConfiguration(
            pointSize: 16,
            weight: .medium
        )
        let backButtonImage = UIImage(systemName: "arrow.left")?.withConfiguration(backButtonImageConfig)
        
        if #available(iOS 15, *) {
            var backButtonConfig = UIButton.Configuration.plain()
            backButtonConfig.baseForegroundColor = .black
            backButtonConfig.image = backButtonImage
            
            backButton.configuration = backButtonConfig
        } else {
            backButton.setImage(backButtonImage, for: .normal)
            backButton.tintColor = .black
        }
    }
    
    class func apply(contentView: UIView) {
        
    }
}
