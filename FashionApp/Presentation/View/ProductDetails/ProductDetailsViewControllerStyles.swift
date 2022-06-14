//
//  ProductDetailsControllerView+Styles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

// MARK: - Interfaces

protocol ProductDetailsViewControllerStyles {
    func apply(imageView: ImageViewShadowed)
    func apply(scrollView: UIScrollView)
    func apply(titleLabel: UILabel)
    func apply(titleLabelLoading: UILabel)
    func apply(brandLabel: UILabel)
    func apply(brandLabelLoading: UILabel)
    func apply(descriptionLabel: UILabel)
    func apply(descriptionLabelLoading: UILabel)
    func apply(cartButton: UIButton)
    func apply(imageDescriptionButton: UIButton)
    func apply(backButton: UIButton)
    func apply(contentView: UIView)
}

// MARK: - Implementations

class DefaultProductDetailsViewControllerStyles: ProductDetailsViewControllerStyles {
    
    var imageCornerRadius: CGFloat {
        15
    }
    
    var imageShadowShape: ShapeCallback {
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
                    cornerWidth: self.imageCornerRadius,
                    cornerHeight: self.imageCornerRadius,
                    transform: nil
                )
            }
            
            return callback
        }
    }
    
    func apply(imageView: ImageViewShadowed) {
        imageView.shadowView.shape = imageShadowShape
        
        let shadowColor = UIColor(red: 0.094, green: 0.153, blue: 0.3, alpha: 1).cgColor
        imageView.shadowView.shadows = [
            ShadowView.ShadowParams(
                color: shadowColor,
                opacity: 0.25,
                radius: 15,
                offset: CGSize(width: 0, height: 8)
            ),
        ]
        
        imageView.imageView.imageView.contentMode = .scaleAspectFit
        imageView.imageView.imageView.alignBottom = true
        
        imageView.containerView.backgroundColor = UIColor(named: "ColorProductCellBackground")
        imageView.containerView.layer.cornerRadius = imageCornerRadius
    }
    
    func apply(scrollView: UIScrollView) {
        scrollView.backgroundColor = UIColor.systemBackground
    }
    
    func apply(contentView: UIView) {
        
    }
    
    func apply(titleLabel: UILabel) {
        GlobalStyles.apply(viewDisabledLoading: titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = Fonts.RedHatDisplay.medium.preferred(with: .largeTitle)
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .clear
    }
    
    func apply(brandLabel: UILabel) {
        GlobalStyles.apply(viewDisabledLoading: brandLabel)
        brandLabel.font = Fonts.RedHatDisplay.semiBold.preferred(with: .body)
        brandLabel.textAlignment = .left
        brandLabel.textColor = UIColor(named: "ColorBrandLabel")
        brandLabel.backgroundColor = .clear
    }
    
    func apply(descriptionLabel: UILabel) {
        GlobalStyles.apply(viewDisabledLoading: descriptionLabel)
        descriptionLabel.font = Fonts.RedHatDisplay.medium.preferred(with: .subheadline)
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor(named: "ColorProductDescription")
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.backgroundColor = .clear
    }
    
    func apply(cartButton: UIButton) {
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
    
    func apply(imageDescriptionButton: UIButton) {
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
    
    func apply(backButton: UIButton) {
        
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
    
    func apply(titleLabelLoading titleLabel: UILabel) {
        apply(titleLabel: titleLabel)
        GlobalStyles.apply(loadingLabel: titleLabel)
    }
    
    func apply(brandLabelLoading brandLabel: UILabel) {
        apply(titleLabel: brandLabel)
        GlobalStyles.apply(loadingLabel: brandLabel)
    }
    
    func apply(descriptionLabelLoading descriptionLabel: UILabel) {
        apply(descriptionLabel: descriptionLabel)
        GlobalStyles.apply(loadingLabel: descriptionLabel)
    }
}
