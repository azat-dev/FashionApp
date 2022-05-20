//
//  ProductViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit

class ProductViewModel {
    private var product: Observable<Product>
    
    var title = Observable("")
    var brand = Observable("")
    var description = Observable("")
    var isDescriptionButtonVisible = Observable(false)
    var image = AsyncImageViewModel()
    var loadedImage: Observable<UIImage?> = Observable(nil)
    
    init(product: Product, loadImage: @escaping LoadImageFunction) {
        self.product = Observable(product)
        self.product.bind {
            [weak self] product, _ in
            
            guard let self = self else {
                return
            }
            
            self.title.value = product.name
            self.brand.value = "FROM \(product.brand)"
            self.description.value = product.description

            self.image.loadImage.value = loadImage
            self.image.url.value = product.image
        }
        
        self.image.didLoadImage = { [weak self] image in
            DispatchQueue.main.async {
                self?.loadedImage.value = image
                self?.isDescriptionButtonVisible.value = image != nil
            }
        }
    }
}

extension ProductViewModel {
    func addToCart() {
        
    }
}
