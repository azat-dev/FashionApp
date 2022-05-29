//
//  ProductDetailsFullScreenImageViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 11.04.22.
//

import Foundation

// MARK: - Protocols

protocol ProductDetailsFullScreenImageViewModelOutput {
    var price: Observable<String> { get }
    var name: Observable<String> { get }
    var isActive: Observable<Bool> { get }
}

protocol ProductDetailsFullScreenImageViewModelInput { }

protocol ProductDetailsFullScreenImageViewModel: ProductDetailsFullScreenImageViewModelOutput & ProductDetailsFullScreenImageViewModelInput { }

// MARK: - Implementation

final class DefaultProductDetailsFullScreenImageViewModel: ProductDetailsFullScreenImageViewModel {
    
    private var product: Observable<Product>
    
    var price = Observable("")
    var name = Observable("")
    var isActive = Observable(false)
    
    init(product: Product) {
        
        self.product = Observable(product)
        
        self.product.observe(on: self) { [weak self] product in
            
            guard let self = self else {
                return
            }
            
            let priceText = String(format: "%.2f", product.price)
            self.price.value = "€\(priceText)"
            self.name.value = product.name
        }
    }
    
    func toggle() {
        isActive.value = !isActive.value
    }
}
