//
//  LocalCartRepository.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.05.22.
//

import Foundation

struct CartItemDTO: Codable {
    var productId: String
    var amount: Int
    
    init(cartItem: CartItem) {
        productId = cartItem.productId
        amount = cartItem.amount
    }
    
    func toDomain() -> CartItem {
        return CartItem(
            productId: productId,
            amount: amount
        )
    }
}

struct CartDTO: Codable {
    var updatedAt: Date?
    var items: [CartItemDTO]
    
    func toDomain() -> Cart {
        return Cart(
            updatedAt: updatedAt,
            items: items.map { $0.toDomain() }
        )
    }
    
    init(cart: Cart) {
        updatedAt = cart.updatedAt
        items = cart.items.map { CartItemDTO(cartItem: $0) }
    }
}

final class LocalCartRepository {
    
    private let localKeyValueStorage: LocalKeyValueStorage
    
    init(localKeyValueStorage: LocalKeyValueStorage) {
        self.localKeyValueStorage = localKeyValueStorage
    }
}

extension LocalCartRepository: CartRepository {
    
    func fetchCart() async -> Result<Cart?, CartUseCaseError> {
        
        let dto = localKeyValueStorage.getItem(key: "cart", as: CartDTO.self)
        return .success(dto?.toDomain())
    }
    
    func putCart(cart: Cart) async -> Result<Cart, CartUseCaseError> {
        
        var dto = CartDTO(cart: cart)
        dto.updatedAt = Date()
        
        localKeyValueStorage.setItem(key: "cart", value: dto)
        
        return .success(dto.toDomain())
    }
}
