//
//  ProductDetailsFullScreenImageViewFactory.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 01.06.22.
//

import Foundation
import UIKit

struct ProductDetailsFullScreenImageContext {
    var product: Product
    var image: UIImage
}

final class ProductDetailsFullScreenImageViewControllerFactory {

    private let coordinator: ProductDetailsFullScreenImageCoordinator
    
    init(
        coordinator: ProductDetailsFullScreenImageCoordinator
    ) {
        
        self.coordinator = coordinator
    }

    func build(with context: ProductDetailsFullScreenImageContext) -> ProductDetailsFullScreenImageViewController {

        let viewModel = DefaultProductDetailsFullScreenImageViewModel(
            product: context.product,
            image: context.image,
            coordinator: coordinator
        )
        
        
        let fullscreenImageViewController = ProductDetailsFullScreenImageViewController(
            viewModel: viewModel,
            styles: DefaultProductDetailsFullScreenImageViewControllerStyles(),
            layout: DefaultProductDetailsFullScreenImageViewControllerLayout()
        )
        
        return fullscreenImageViewController
    }
}
