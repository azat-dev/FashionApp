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
        asyncImageView: AsyncImageViewAligned,
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
        asyncImageView: AsyncImageViewAligned,
        nameLabel: UILabel,
        brandLabel: UILabel,
        priceLabel: UILabel
    ) {
        asyncImageView.imageView.contentMode = .scaleAspectFill
        asyncImageView.imageView.alignBottom = true
    
        imageShadow.snp.makeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide)
            make.horizontalEdges.equalTo(contentView.layoutMarginsGuide)
        }
        
        imageContainer.snp.makeConstraints { make in
            make.edges.equalTo(imageShadow)
        }
        
        asyncImageView.snp.makeConstraints { make in
            make.width.equalTo(imageContainer)
            make.height.equalTo(imageContainer).multipliedBy(0.97)
            make.bottom.equalTo(imageContainer)
            make.centerX.equalTo(imageContainer)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageContainer.snp.bottom).offset(8)
            make.left.equalTo(imageContainer)
            make.right.lessThanOrEqualTo(imageContainer)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.left.equalTo(imageContainer)
            make.right.lessThanOrEqualTo(imageContainer)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(5)
            make.left.equalTo(imageContainer)
            make.right.lessThanOrEqualTo(imageContainer)
            make.bottom.equalTo(contentView.layoutMarginsGuide)
        }
    }
}
