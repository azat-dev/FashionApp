//
//  ProductDetailsControllerViewLayout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

protocol ProductDetailsViewLayoutable {
    static func apply(
        view: UIView,
        scrollView: UIScrollView,
        contentView: UIView,
        imageShadow: ShadowView,
        imageContainer: ShapedView,
        imageView: UIImageViewAligned,
        titleLabel: UILabel,
        brandLabel: UILabel,
        descriptionLabel: UILabel,
        backButton: UIButton,
        imageDescriptionButton: UIButton,
        cartButton: UIButton
    )
}

class ProductDetailsViewControllerLayout: ProductDetailsViewLayoutable {
    class func apply(
        view: UIView,
        scrollView: UIScrollView,
        contentView: UIView,
        imageShadow: ShadowView,
        imageContainer: ShapedView,
        imageView: UIImageViewAligned,
        titleLabel: UILabel,
        brandLabel: UILabel,
        descriptionLabel: UILabel,
        backButton: UIButton,
        imageDescriptionButton: UIButton,
        cartButton: UIButton
    ) {
        scrollView.frame = view.frame
        
        UIView.disableAutoresizingMaskIntoConstraints(views: [
            scrollView,
            cartButton,
            contentView,
            brandLabel,
            backButton,
            imageShadow,
            imageView,
            imageContainer,
            titleLabel,
            imageDescriptionButton,
            descriptionLabel
        ])
        
        imageShadow.constraintAll(equalTo: imageContainer)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.98),
        ])
        
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageContainer.heightAnchor.constraint(equalTo: imageContainer.widthAnchor, multiplier: 1.37, constant: 0),
            
            imageView.topAnchor.constraint(greaterThanOrEqualTo: imageContainer.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            imageView.widthAnchor.constraint(lessThanOrEqualTo: imageContainer.widthAnchor),
            imageView.heightAnchor.constraint(lessThanOrEqualTo: imageContainer.heightAnchor, multiplier: 0.97),
        ])
        
        NSLayoutConstraint.activate([
            imageDescriptionButton.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -20),
            imageDescriptionButton.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -18),
        ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: imageContainer.topAnchor, constant: 15),
            backButton.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor, constant: 10),

            titleLabel.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            brandLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            brandLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            cartButton.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            cartButton.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),

            cartButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cartButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
