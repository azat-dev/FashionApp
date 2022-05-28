//
//  Cart.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.05.22.
//

import Foundation


struct CartItem: Equatable {
    var productId: String
    var amount: Int
}

struct Cart {
    var updatedAt: Date?
    var items: [CartItem]
}
