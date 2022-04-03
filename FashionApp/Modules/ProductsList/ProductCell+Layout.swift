//
//  ProductCell+Layout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit

class ProductCellLayout: ProductCellLayoutable {
    static func apply (
        contentView: UIView,
        shapedImage: ShapedImageView,
        nameLabel: UILabel,
        brandLabel: UILabel,
        priceLabel: UILabel
    ) {
        let inset = CGFloat(0)
        shapedImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shapedImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            shapedImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shapedImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: shapedImage.leadingAnchor, constant: inset),
            nameLabel.trailingAnchor.constraint(equalTo: shapedImage.trailingAnchor, constant: -inset),
            
            nameLabel.topAnchor.constraint(equalTo: shapedImage.bottomAnchor, constant: 10),
            
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
