//
//  ProductCell+Layout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift
import SnapKit

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
    
        imageView.contentMode = .scaleAspectFill
        imageView.alignBottom = true
    
        imageShadow.snp.makeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide)
            make.horizontalEdges.equalTo(contentView.layoutMarginsGuide)
        }
        
        imageContainer.snp.makeConstraints { make in
            make.edges.equalTo(imageShadow)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(imageContainer)
            make.height.equalTo(imageContainer).multipliedBy(0.97)
            make.bottom.equalTo(imageContainer)
            make.centerX.equalTo(imageContainer)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageContainer.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(imageContainer)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.horizontalEdges.equalTo(imageContainer)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(imageContainer)
            make.bottom.equalTo(contentView.layoutMarginsGuide)
        }
    }
}
