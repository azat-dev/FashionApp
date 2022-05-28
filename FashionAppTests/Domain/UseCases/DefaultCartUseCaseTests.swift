//
//  DefaultCartUseCaseTests.swift
//  FashionAppTests
//
//  Created by Azat Kaiumov on 28.05.22.
//

import XCTest
@testable import FashionApp

class DefaultCartUseCaseTests: XCTestCase {
    
    var cartRepository: CartRepository
    var cartUseCase: CartUseCase!
    
    override func setUp() async throws {
        
        cartRepository = DefaultCartRepository()
        cartUseCase = DefaultCartUseCase(cartRepository: cartRepository)
    }
    
    func test_fetch_cart() async {
        
        let result = await cartUseCase.fetchCart()
        
        guard case .success(let cart) = result else {
            XCTAssertFalse(true, "Can't get cart")
            return
        }
    }
}
