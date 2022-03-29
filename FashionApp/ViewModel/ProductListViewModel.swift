//
//  ProductListViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation

private let defaultDescription = """
Short sleeve silk shirt with Hawaiian print. Classic
monogram, spread collar and corozo buttons.
100% silk. Made in Italy. With classic case
"""


class ProductListViewModel {
    private var data: [Product] = [
        Product(id: "1", brand: "NIKE", name: "Comfort Jacket", price: 450, description: defaultDescription),
        Product(id: "2", brand: "NIKE", name: "Fleming Jacket", price: 450, description: defaultDescription),
        Product(id: "3", brand: "NIKE", name: "Fleming Jacket", price: 450, description: defaultDescription),
        Product(id: "4", brand: "NIKE", name: "Fleming Jacket", price: 450, description: defaultDescription),
        Product(id: "5", brand: "NIKE", name: "Fleming Jacket", price: 450, description: defaultDescription),
        Product(id: "6", brand: "NIKE", name: "Fleming Jacket", price: 450, description: defaultDescription)
    ]
    
    var numberOfItems: Int {
        data.count
    }
    
    func getProduct(at index: Int) -> Product {
        return data[index]
    }
}
