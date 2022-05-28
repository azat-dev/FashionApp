//
//  Cart.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.05.22.
//

import Foundation


struct CartItem {
    var productId: String
    var amount: String
}

struct Cart {
    var updatedAt: Date?
    var items: [CartItem]
}
