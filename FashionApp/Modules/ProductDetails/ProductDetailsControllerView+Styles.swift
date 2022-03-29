//
//  ProductDetailsControllerView+Styles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit

// MARK: - Style Views
extension ProductDetailsViewController {
    func style(shapedImageView: ShapedImageView) {
        shapedImageView.translatesAutoresizingMaskIntoConstraints = false
        shapedImageView.imageView.backgroundColor = UIColor(named: "ColorProductCellBackground")
    }

    func style(titleLabel: UILabel) {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(name: "RedHatDisplay-Medium", forTextStyle: .largeTitle)
        titleLabel.textAlignment = .left
    }

    func style(descritptionLabel: UILabel) {
        descritptionLabel.font = UIFont.preferredFont(name: "RedHatDisplay-Medium", forTextStyle: .subheadline)
        descritptionLabel.textAlignment = .left
        descritptionLabel.textColor = UIColor(named: "ColorProductDescription")
        descritptionLabel.lineBreakMode = .byWordWrapping
        descritptionLabel.numberOfLines = 0
    }

    func style(brandLabel: UILabel) {
        brandLabel.font = UIFont.preferredFont(name: "RedHatDisplay-Medium", forTextStyle: .body)
        brandLabel.textAlignment = .left
        brandLabel.textColor = UIColor(named: "ColorBrandLabel")
    }

    func style(backButton: UIButton) {
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

    func style(cartButton: UIButton) {
        let cartButtonCornerRadius: CGFloat = 12
        let cartButtonImage = UIImage(systemName: "cart")
        let cartButtonBackgroundColor = UIColor(named: "ColorProductCellBackground")
        let cartButtonFont = UIFont.preferredFont(name: "RedHatDisplay-Medium", forTextStyle: .body)
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
    
    func style(imageDescriptionButton: UIButton) {
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
            
            imageDescriptionButton.translatesAutoresizingMaskIntoConstraints = false
            imageDescriptionButton.configuration = imageDescriptionButtonConfig
        }
    }
    
    func style(scrollView: UIScrollView) {
        scrollView.backgroundColor = UIColor.systemBackground
    }
}

extension ProductDetailsViewController: ShapeDelegate {
    func shape(view containerView: UIView) -> CGPath? {
        return CGPath(
            roundedRect: containerView.bounds,
            cornerWidth: 20,
            cornerHeight: 20,
            transform: nil
        )
    }
}
