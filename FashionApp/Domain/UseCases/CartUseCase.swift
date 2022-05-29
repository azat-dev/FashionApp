//
//  CartUseCase.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.05.22.
//

import Foundation

// MARK: - Interfaces

enum CartUseCaseError: Error {
    
    case internalError(Error?)
}

protocol CartUseCase {
    
    func putProduct(productId: String, amount: Int) async -> Result<Cart, CartUseCaseError>
    
    func fetchCart() async -> Result<Cart?, CartUseCaseError>
    
    func removeProduct(productId: String) async -> Result<Cart?, CartUseCaseError>
}

// MARK: - Implementations

final class DefaultCartUseCase {
    
    private var isAuthorized: Bool = false
    
    private var localCartRepository: CartRepository
    
    init(localCartRepository: CartRepository) {
        self.localCartRepository = localCartRepository
    }
}

extension DefaultCartUseCase: CartUseCase {
    
    func putProduct(productId: String, amount: Int) async -> Result<Cart, CartUseCaseError> {

        return await putProduct(
            to: isAuthorized ? localCartRepository : localCartRepository,
            productId: productId,
            amount: amount
        )
    }
    
    private func putProduct(to repository: CartRepository, productId: String, amount: Int) async -> Result<Cart, CartUseCaseError> {
            
        let cartResult = await repository.fetchCart()
            
        switch cartResult {
        case .failure(let error):
            return .failure(error)
            
        case .success(let cart):
            var newCart = cart ?? Cart(items: [])
            newCart.put(item: CartItem(productId: productId, amount: amount))
            return await repository.putCart(cart: newCart)
        }
    }
    
    func fetchCart() async -> Result<Cart?, CartUseCaseError> {
        return await localCartRepository.fetchCart()
    }
    
    func removeProduct(productId: String) async -> Result<Cart?, CartUseCaseError> {

        let cartResult = await localCartRepository.fetchCart()
        
        switch cartResult {
        case .failure(_):
            return cartResult
            
        case .success(let cart):
            guard let cart = cart else {
                return .success(nil)
            }
            
            var newCart = cart
            newCart.removeItem(productId: productId)
            
            let putResult = await localCartRepository.putCart(cart: newCart)
            
            switch putResult {
            case .failure(let error):
                return .failure(error)
            case .success(let savedCart):
                return .success(savedCart)
            }
        }
    }
}
