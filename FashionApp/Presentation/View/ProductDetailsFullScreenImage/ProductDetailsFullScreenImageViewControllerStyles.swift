//
//  ProductDetailsFullScreenImageStyles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 07.04.22.
//

import Foundation
import UIImageViewAlignedSwift
import UIKit

// MARK: - Interfaces

protocol ProductDetailsFullScreenImageViewControllerStyles {
    func apply(view: UIView)
    func apply(backButton: UIButton)
    func apply(buyButton: UIButton)
    func apply(imageView: UIImageViewAligned)
}

// MARK: - Implementations

final class DefaultProductDetailsFullScreenImageViewControllerStyles: ProductDetailsFullScreenImageViewControllerStyles {

    func apply(view: UIView) {
        
        view.backgroundColor = UIColor(named: "ColorProductCellBackground")
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
        
        var configuration = UIButton.Configuration.plain()
        
        configuration.baseForegroundColor = .black
        configuration.image = image
        backButton.configuration = configuration
    }
    
    func apply(buyButton: UIButton) {
        
        let title = "Go buy"
        let cornerRadius: CGFloat = 12
        let image = UIImage(systemName: "arrow.forward")
        let font = Fonts.RedHatDisplay.medium.preferred(with: .body)
        let borderColor = UIColor(named: "ColorBuyButtonBorder")
        let insets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
        
        guard #available(iOS 15, *) else {
            buyButton.setTitle(title, for: .normal)
            return
        }
        
        var configuration = UIButton.Configuration.bordered()

        var attString = AttributedString(title)
        attString.font = font
        
        configuration.attributedTitle = attString
        configuration.titleAlignment = .center
        configuration.baseForegroundColor = .white
        
        configuration.background.strokeWidth = 1
        configuration.background.strokeColor = borderColor
        configuration.background.backgroundColor = .clear
        
        configuration.image = image
        configuration.imagePadding = 20
        configuration.imagePlacement = .trailing
        configuration.cornerStyle = .large
        configuration.contentInsets = insets
        configuration.background.visualEffect = UIBlurEffect(style: .regular)
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = cornerRadius
        
        buyButton.configuration = configuration
    }
    
    func apply(imageView: UIImageViewAligned) {
    
        imageView.contentMode = .scaleAspectFit
        imageView.alignBottom = true
    }
}
