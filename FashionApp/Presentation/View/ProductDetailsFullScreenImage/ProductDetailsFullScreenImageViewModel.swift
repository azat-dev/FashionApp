//
//  ProductDetailsFullScreenImageViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 11.04.22.
//

import Foundation
import UIKit

// MARK: - Protocols

typealias ProductDetailsFullScreenImageCoordinator = GoingBack

protocol ProductDetailsFullScreenImageViewModelOutput {
    var price: Observable<String> { get }
    var name: Observable<String> { get }
    var image: Observable<UIImage?> { get }
    var isActive: Observable<Bool> { get }
}

protocol ProductDetailsFullScreenImageViewModelInput {
    func goBack()
}

protocol ProductDetailsFullScreenImageViewModel: ProductDetailsFullScreenImageViewModelOutput & ProductDetailsFullScreenImageViewModelInput { }

// MARK: - Implementation

final class DefaultProductDetailsFullScreenImageViewModel: ProductDetailsFullScreenImageViewModel {
    
    private let coordinator: ProductDetailsFullScreenImageCoordinator
    private let product: Observable<Product>
    
    var price = Observable("")
    var name = Observable("")
    var isActive = Observable(false)
    var image = Observable<UIImage?>(nil)
    
    init(product: Product, image: UIImage, coordinator: ProductDetailsFullScreenImageCoordinator) {
        
        self.product = Observable(product)
        self.coordinator = coordinator
        self.image.value = image
        
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
    
    func goBack() {
        coordinator.goBack()
    }
}
