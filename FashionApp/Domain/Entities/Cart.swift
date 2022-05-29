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

extension Cart {
    
    mutating func put(item: CartItem) {
        
        let index = items.firstIndex { cartItem in cartItem.productId == item.productId }
        
        guard let index = index else {
            items.append(item)
            return
        }
        
        items[index] = item
    }
    
    mutating func removeItem(productId: String) {
        
        items.removeAll { item in item.productId == productId }
    }
}
