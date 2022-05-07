//
//  ProductCellViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 27.03.22.
//

import Foundation
import UIKit

class ProductCellViewModel {
    private var product: Observable<Product?> = Observable(nil) {
        didSet {
            product.bind {
                [unowned self] (product, _) in
                self.update(from: product)
            }
        }
    }
    
    var isLoading = Observable(true)
    var name = Observable("")
    var price = Observable("")
    var brand = Observable("")
    var imageUrl: Observable<String?> = Observable(nil)
    var imageLoader: ImageLoader!
    
    init(imageLoader: ImageLoader, product: Product? = nil) {
        self.imageLoader = imageLoader
        self.product.value = product
        
        self.product.bind {
            [unowned self] (product, _) in
            self.update(from: product)
        }
    }
}

extension ProductCellViewModel {
    private func update(from product: Product?) {
        
        guard let product = product else {
            self.name.value = "Loading product"
            self.brand.value = "Brand Name"
            self.price.value = "€000"
            self.imageUrl.value = nil
            self.isLoading.value = true
            return
        }
        
        
        self.name.value = product.name
        self.brand.value = "From \(product.brand)"
        let priceText = String(format: "%.0f", product.price)
        self.price.value = "€\(priceText)"
        self.imageUrl.value = product.image
        self.isLoading.value = false
    }
    
    func getProduct() -> Product? {
        return product.value
    }
}

extension ProductCellViewModel {
    private func open() {
        
    }
}
