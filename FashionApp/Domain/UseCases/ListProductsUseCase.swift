//
//  ListProductsUseCase.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 22.05.22.
//

import Foundation

protocol ListProductsUseCase {
    func execute(from: Int, limit: Int, completion: @escaping (_ result: Result<Page<Product>, Error>) -> Void) -> Void
}

final class DefaultListProductsUseCase: ListProductsUseCase {
    private let productsRepository: ProductsRepository
    
    init(productsRepository: ProductsRepository) {
        self.productsRepository = productsRepository
    }
    
    func execute(from: Int, limit: Int, completion: @escaping (_ result: Result<Page<Product>, Error>) -> Void) {
        productsRepository.fetchProducts(from: 0, limit: 0) { result in
            completion(result)
        }
    }
}
