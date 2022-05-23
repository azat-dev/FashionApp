//
//  ProductDetailsFullScreenImageLayout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 07.04.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

protocol ProductDetailsFullScreenImageLayoutable {
    static func apply(
        view: UIView,
        backButton: UIButton,
        imageView: UIImageViewAligned,
        buyButton: UIButton
    )
}

class ProductDetailsFullScreenImageLayout: ProductDetailsFullScreenImageLayoutable {
    static func apply(view: UIView, backButton: UIButton, imageView: UIImageViewAligned, buyButton: UIButton) {
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.lessThanOrEqualTo(view).multipliedBy(0.98)
            make.height.lessThanOrEqualTo(view).multipliedBy(0.95)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        buyButton.snp.makeConstraints { make in
            make.bottomMargin.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
        }
    }
}
