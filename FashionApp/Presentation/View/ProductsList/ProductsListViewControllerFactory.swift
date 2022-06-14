//
//  ProductsListViewControllerFactory.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 31.05.22.
//

import Foundation

final class ProductsListViewControllerFactory {

    private let productsRepository: ProductsRepository
    
    private let imagesRepository: ImagesRepository
    
    private let coordinator: ProductsListCoordinator
    
    init(
        coordinator: ProductsListCoordinator,
        productsRepository: ProductsRepository,
        imagesRepository: ImagesRepository
    ) {
        
        self.coordinator = coordinator
        self.productsRepository = productsRepository
        self.imagesRepository = imagesRepository
    }

    func build() -> ProductsListViewController {

        let viewModel = DefaultProductsListViewModel(
            productsRepository: productsRepository,
            imagesRepository: imagesRepository,
            coordinator: coordinator
        )
        
        let listViewController = ProductsListViewController(
            viewModel: viewModel,
            styles: ProductsListViewControllerStyles(),
            layout: DefaultProductsListViewControllerLayout()
        )
        
        return listViewController
    }

}
