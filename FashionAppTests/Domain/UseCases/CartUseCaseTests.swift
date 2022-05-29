//
//  CartUseCaseTests.swift
//  FashionAppTests
//
//  Created by Azat Kaiumov on 29.05.22.
//

@testable import FashionApp
import XCTest

class CartUseCaseTests: XCTestCase {

    var localStorage: LocalKeyValueStorage!
    var cartUseCase: CartUseCase!
    var localCartRepository: LocalCartRepository!
    
    override func setUpWithError() throws {
        
        localStorage = LocalKeyValueStorage()
        localCartRepository = LocalCartRepository(localKeyValueStorage: localStorage)
        cartUseCase = CartUseCase(localCartRepository: localCartRepository)
    }
    
    func test_add_product() async throws {
        
        let numberOfProducts = 3

        for index in 0..<numberOfProducts {
            
            let result = await cartUseCase.putProduct(productId: "product_\(index)", amount: index)
            if case .success = result {
                XCTAssertFalse(true, "Can't add product")
                return
            }
        }
        
        let cartResult = await cartUseCase.fetchCart()
        
        guard case .success(let cart) = cartResult else {
            XCTAssertFalse(true, "Can't fetch cart")
            return
        }
        
        XCTAssertEqual(cart.items.count, numberOfProducts)
        
        for index in 0..<numberOfProducts {
            
            let productId = "product_\(index)"
            let productData = cart.items.first { $0.productId == productId }
            
            XCTAssertEqual(productData.amount, index)
        }
    }
    
    func test_update_product_amount() {
        
        let result1 = await cartUseCase.putProduct(productId: "product_1", amount: 1)
        
        guard case .success = result1 else {
            XCTAssertFalse(true, "Can't put product")
            return
        }
        
        let result2 = await cartUseCase.putProduct(productId: "product_2", amount: 2)
        
        guard case .success = result2 else {
            XCTAssertFalse(true, "Can't put product")
            return
        }
        
        let result3 = await cartUseCase.putProduct(productId: "product_2", amount: 5)
        
        guard case .success = result1 else {
            XCTAssertFalse(true, "Can't put product")
            return
        }
        
        let cartResult = await cartUseCase.fetchCart()
        
        guard case .success(let cart) = cartResult else {
            XCTAssertFalse(true, "Can't fetch cart")
            return
        }
        
        XCTAssertEqual(cart.items.count, 2)
        
        let product1 = cart.items.first { $0.productId == "product_1" }
        XCTAssertEqual(product1.amount, 1)

        let product2 = cart.items.first { $0.productId == "product_2" }
        XCTAssertEqual(product2.amount, 5)
    }
    
    func test_remove_product() {
        
        let result1 = await cartUseCase.putProduct(productId: "product_1", amount: 1)
        
        guard case .success = result1 else {
            XCTAssertFalse(true, "Can't put product")
            return
        }
        
        let result2 = await cartUseCase.putProduct(productId: "product_2", amount: 2)
        
        guard case .success = result2 else {
            XCTAssertFalse(true, "Can't put product")
            return
        }
        
        let cartResult = await cartUseCase.fetchCart()
        
        guard case .success(let cart) = cartResult else {
            XCTAssertFalse(true, "Can't fetch cart")
            return
        }
        
        
        XCTAssertEqual(cart.items.count, 2)
        
        let result = await cartUseCase.removeProduct(productId: "product_1")
        
        
        let cartResultAfter = await cartUseCase.fetchCart()
        
        guard case .success(let cartAfter) = cartResultAfter else {
            XCTAssertFalse(true, "Can't fetch cart")
            return
        }
        
        
        XCTAssertEqual(cart.items.count, 1)
        XCTAssertEqual(cart.items.first?.productId, "product_2")
    }
}
