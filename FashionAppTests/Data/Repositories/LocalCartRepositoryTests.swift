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
    
    func test_get_cart_not_existing() {
        
        XCTAssertNil(await cartRepository.fetchCart())
    }
    
    func test_get_cart_existing() {
        
        XCTAssertNotNil(await cartRepository.fetchCart())
    }
    
    func test_put_new_cart() {
        
        let cart = Cart(
            createdAt: nil
            items: []
        )
        
        let result = await cartRepository.putCart()
        
        guard case .success(savedCart) = result else {
            XCTAssertFalse(true, "Can't save cart")
            return
        }
        
        XCTAssertNotNil(savedCart)
        XCTAssertEqual(savedCart.items.count, cart.items.count)
    }
}
