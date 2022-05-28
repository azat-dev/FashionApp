//
//  LocalCartRepositoryTests.swift
//  FashionAppTests
//
//  Created by Azat Kaiumov on 28.05.22.
//

import XCTest
@testable import FashionApp

class LocalCartRepositoryTests: XCTestCase {
    
    var storage: LocalKeyValueStorage!
    var cartRepository: LocalCartRepository!
    
    override func setUp() async throws {

        storage = DefaultLocalKeyValueStorage()
        cartRepository = LocalCartRepository(localKeyValueStorage: storage)
    }
    
    func test_get_cart_not_existing() async {
        
        let result = await cartRepository.fetchCart()
        
        guard case .success(let cart) = result else {
            XCTAssertFalse(true, "Can't get cart")
            return
        }
            
        XCTAssertNil(cart)
    }
    
    func test_put_new_cart() async {

        let cart = Cart(
            updatedAt: nil,
            items: [
                CartItem(productId: "1", amount: 1),
                CartItem(productId: "2", amount: 2),
            ]
        )

        let result = await cartRepository.putCart(cart: cart)

        guard case .success(let savedCart) = result else {
            XCTAssertFalse(true, "Can't save cart")
            return
        }

        XCTAssertNotNil(savedCart)
        XCTAssertEqual(savedCart.items.count, cart.items.count)
        XCTAssertEqual(savedCart.items, cart.items)
    }
}
