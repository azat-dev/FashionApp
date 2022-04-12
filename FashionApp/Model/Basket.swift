//
//  Basket.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 11.04.22.
//

import Foundation

struct BasketRow {
    var product: Product
    var count: Int = 0
    
    var total: Double {
        Double(product.price) * Double(count)
    }
}

struct Basket {
    var rows: [BasketRow]
    
    var total: Double {
        rows.reduce(0.0, { $0 + $1.total })
    }
}
