//
//  ProductViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit

class ProductViewModel {
    private var product: Observable<Product?> = Observable(nil)
    
    private var productId: String
    private var productsRepository: ProductsRepository
    
    var isLoading = Observable(false)
    var isLoadingFailed = Observable(false)
    var title = Observable("")
    var brand = Observable("")
    var description = Observable("")
    var isDescriptionButtonVisible = Observable(false)
    var image = AsyncImageViewModel()
    var loadedImage: Observable<UIImage?> = Observable(nil)
    
    
    init(productId: String, productsRepository: ProductsRepository) {
        self.isLoading.value = true
        self.productId = productId
        self.productsRepository = productsRepository
        self.product.bind { [weak self] product, _ in
            self?.update(from: product)
        }
    }

    func load() {
        productsRepository.fetchProduct(id: productId) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .failure(_):
                self.isLoadingFailed.value = true
            case .success(let product):
                self.product.value = product
            }
            
            self.isLoading.value = false
        }
    }
        
//    init(product: Product, loadImage: @escaping LoadImageFunction) {
//
//        self.image.didLoadImage = { [weak self] image in
//            DispatchQueue.main.async {
//                self?.loadedImage.value = image
//                self?.isDescriptionButtonVisible.value = image != nil
//            }
//        }
//    }
    
    func update(from product: Product?) {
        guard let product = product else {
            self.isLoading.value = true
            return
        }

        self.title.value = product.name
        self.brand.value = "FROM \(product.brand)"
        self.description.value = product.description

//        self.image.loadImage.value = loadImage
        self.image.url.value = product.image
        self.isLoading.value = false
    }
}

extension ProductViewModel {
    func addToCart() {
        
    }
}
