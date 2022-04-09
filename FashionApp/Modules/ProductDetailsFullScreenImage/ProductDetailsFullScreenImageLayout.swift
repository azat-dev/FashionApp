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
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.98),
            imageView.heightAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.9),
            imageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            buyButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
            buyButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            buyButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
