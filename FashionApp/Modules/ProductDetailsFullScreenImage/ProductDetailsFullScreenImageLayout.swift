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
        
        UIView.disableAutoresizingMaskIntoConstraints(views: [
            imageView,
            backButton,
            buyButton
        ])
        
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        view.constraintAll(equalTo: imageView)
        
        NSLayoutConstraint.activate([
            buyButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
            buyButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            buyButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
