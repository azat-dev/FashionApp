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
    
    func test_put_update_existing_cart() async {

        let cart1 = Cart(
            updatedAt: nil,
            items: [
                CartItem(productId: "1", amount: 1),
                CartItem(productId: "2", amount: 2),
            ]
        )

        let result = await cartRepository.putCart(cart: cart1)

        guard case .success(let savedCart1) = result else {
            XCTAssertFalse(true, "Can't save cart")
            return
        }

        XCTAssertNotNil(savedCart1)
        XCTAssertEqual(savedCart1.items.count, cart1.items.count)
        XCTAssertEqual(savedCart1.items, cart1.items)
        
        let cart2 = Cart(
            updatedAt: savedCart1.updatedAt,
            items: [
                CartItem(productId: "3", amount: 3),
                CartItem(productId: "4", amount: 4),
            ]
        )

        let result2 = await cartRepository.putCart(cart: cart2)

        guard case .success(let savedCart2) = result2 else {
            XCTAssertFalse(true, "Can't save cart")
            return
        }

        XCTAssertNotNil(savedCart2)
        XCTAssertNotEqual(savedCart2.updatedAt, cart2.updatedAt)
        XCTAssertEqual(savedCart2.items.count, cart2.items.count)
        XCTAssertEqual(savedCart2.items, cart2.items)
    }
}
