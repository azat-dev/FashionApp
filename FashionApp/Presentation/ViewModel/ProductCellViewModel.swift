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
            product.observe(on: self) { [unowned self] product in
                self.update(from: product)
            }
        }
    }
    
    var isLoading = Observable(true)
    var name = Observable("")
    var price = Observable("")
    var brand = Observable("")
    var imageViewModel: AsyncImageViewModel
    
    init(product: Product?, imagesRepository: ImagesRepository) {

        self.product.value = product
        self.imageViewModel = AsyncImageViewModel(imagesRepository: imagesRepository)
        
        self.product.observe(on: self) {
            [unowned self] product in
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
            self.isLoading.value = true
            self.imageViewModel.url.value = nil
            return
        }
        
        
        self.name.value = product.name
        self.brand.value = "From \(product.brand)"
        let priceText = String(format: "%.0f", product.price)
        self.price.value = "€\(priceText)"
        self.isLoading.value = false
        self.imageViewModel.url.value = product.image
    }
    
    func getProduct() -> Product? {
        return product.value
    }
}

extension ProductCellViewModel {
    private func open() {
        
    }
}
