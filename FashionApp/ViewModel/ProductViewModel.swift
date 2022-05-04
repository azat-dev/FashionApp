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
    var image = Observable(UIImage(named: "ImageTestHoodie"))
    
    init(product: Product) {
        self.product = Observable(product)
        self.product.bind {
            [weak self] product, _ in
            
            guard let self = self else {
                return
            }
            
            self.title.value = product.name
            self.brand.value = "FROM \(product.brand)"
            self.description.value = product.description
        }
    }
}

extension ProductViewModel {
    func addToCart() {
        
    }
}
