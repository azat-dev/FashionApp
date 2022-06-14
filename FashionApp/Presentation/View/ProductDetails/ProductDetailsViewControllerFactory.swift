//
//  ProductDetailsViewControllerFactory.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 31.05.22.
//

import Foundation

final class ProductDetailsViewControllerFactory {

    typealias ViewController = ProductDetailsViewController

    typealias Context = String

    private let productsRepository: ProductsRepository
    private let imagesRepository: ImagesRepository
    private let coordinator: ProductDetailsCoordinator
    
    init(coordinator: ProductDetailsCoordinator, productsRepository: ProductsRepository, imagesRepository: ImagesRepository) {
        
        self.coordinator = coordinator
        self.productsRepository = productsRepository
        self.imagesRepository = imagesRepository
    }

    func build(with productId: Context) -> ViewController {

        let viewModel = DefaultProductDetailsViewModel(
            productId: productId,
            productsRepository: productsRepository,
            imagesRepository: imagesRepository,
            coordinator: coordinator
        )
        
        let productViewController = ProductDetailsViewController(
            viewModel: viewModel,
            styles: DefaultProductDetailsViewControllerStyles(),
            layout: DefaultProductDetailsViewControllerLayout()
        )
        
        return productViewController
    }
}
