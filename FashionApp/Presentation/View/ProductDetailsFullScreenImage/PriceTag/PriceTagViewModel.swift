//
//  PriceTagViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 11.04.22.
//

import Foundation
import UIKit

// MARK: - Interfaces

protocol PriceTagViewModelOutput {
    
    var price: Observable<String>  { get }
    var name: Observable<String> { get }
    var isActive: Observable<Bool> { get }
    var point: CGPoint { get }
}

protocol PriceTagViewModelInput { }

typealias PriceTagViewModel = PriceTagViewModelOutput & PriceTagViewModelInput

// MARK: - Implementations

final class DefaultPriceTagViewModel: PriceTagViewModel {
    
    private var product: Observable<Product>
    
    var price = Observable("100")
    var name = Observable("Test Name")
    var isActive = Observable(false)
    var point: CGPoint
    
    init(product: Product, point: CGPoint) {
        
        self.point = point
        
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
