//
//  ProductDetailsFullScreenImageViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 11.04.22.
//

import Foundation

class ProductDetailsFullScreenImageViewModel {
    private var product: Observable<Product>
    
    var price = Observable("")
    var name = Observable("")
    var isActive = Observable(false)
    
    init(product: Product) {
        self.product = Observable(product)
        
        self.product.bind {
            [weak self] (product, _) in
            
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
