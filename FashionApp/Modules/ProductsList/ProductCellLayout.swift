//
//  ProductCell+Layout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

protocol ProductCellLayoutable {
    static func apply (
        contentView: UIView,
        imageShadow: ShadowView,
        imageContainer: ShapedView,
        imageView: UIImageViewAligned,
        nameLabel: UILabel,
        brandLabel: UILabel,
        priceLabel: UILabel
    )
}

class ProductCellLayout: ProductCellLayoutable {
    static func apply (
        contentView: UIView,
        imageShadow: ShadowView,
        imageContainer: ShapedView,
        imageView: UIImageViewAligned,
        nameLabel: UILabel,
        brandLabel: UILabel,
        priceLabel: UILabel
    ) {
        let inset = CGFloat(0)

        imageShadow.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
    
        imageShadow.constraintAll(equalTo: imageContainer)
        imageView.contentMode = .scaleAspectFill
        imageView.alignBottom = true

        
        NSLayoutConstraint.activate([

            imageShadow.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            imageShadow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageShadow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageView.widthAnchor.constraint(lessThanOrEqualTo: imageContainer.widthAnchor),
            imageView.heightAnchor.constraint(lessThanOrEqualTo: imageContainer.heightAnchor, multiplier: 0.97),
            imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: imageShadow.leadingAnchor, constant: inset),
            nameLabel.trailingAnchor.constraint(equalTo: imageShadow.trailingAnchor, constant: -inset),

            nameLabel.topAnchor.constraint(equalTo: imageShadow.bottomAnchor, constant: 10),

            brandLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            brandLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            brandLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            priceLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}
