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
        imageView: ImageViewShadowed,
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
        imageView: ImageViewShadowed,
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
            imageView,
            titleLabel,
            imageDescriptionButton,
            descriptionLabel,
            contentView
        ])
        
        contentView.layoutMargins = .zero
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

            contentView.layoutMarginsGuide.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.layoutMarginsGuide.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            contentView.layoutMarginsGuide.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.98),
        ])
        
        NSLayoutConstraint.deactivate(imageView.imageView.constraints)
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.37, constant: 0),
            
//            imageView.imageView.bottomAnchor.constraint(equalTo: imageView.containerView.bottomAnchor),
//            imageView.imageView.heightAnchor.constraint(equalTo: imageView.containerView.heightAnchor, multiplier: 0.97),
//            imageView.imageView.widthAnchor.constraint(lessThanOrEqualTo: imageView.containerView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageDescriptionButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            imageDescriptionButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -18),
        ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 15),
            backButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            brandLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            brandLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            cartButton.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            cartButton.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),

            cartButton.centerXAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor),
            cartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
}
