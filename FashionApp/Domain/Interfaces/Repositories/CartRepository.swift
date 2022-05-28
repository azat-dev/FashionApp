//
//  CartRepository.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.05.22.
//

import Foundation

protocol CartRepository {
    func fetchCart() async -> Result<Cart?, CartUseCaseError>
    func putCart(cart: Cart) async -> Result<Cart, CartUseCaseError>
}
