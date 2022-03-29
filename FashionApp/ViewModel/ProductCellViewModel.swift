//
//  ProductCellViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 27.03.22.
//

import Foundation
import UIKit

class ProductCellViewModel {
    private var product: Observable<Product> {
        didSet {
            product.bind {
                [unowned self] product in
                self.update(from: product)
            }
        }
    }
    
    var name = Observable("")
    var price = Observable("")
    var brand = Observable("")
    var image = Observable(UIImage(named: "ImageTestHoodie"))
    
    
    init(product: Product) {
        self.product = Observable(product)
        self.product.bind {
            [unowned self] product in
            self.update(from: product)
        }
    }
}

extension ProductCellViewModel {
    private func update(from product: Product) {
        self.name.value = product.name
        self.brand.value = "From \(product.brand)"
        self.price.value = "€\(product.price)"
    }
}

extension ProductCellViewModel {
    private func open() {
        
    }
}
