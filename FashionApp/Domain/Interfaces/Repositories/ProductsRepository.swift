//
//  ProductsRepository.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 22.05.22.
//

import Foundation

struct Page<T> {
    var total: Int
    var items: [T]
}

protocol ProductsRepository {
    func fetchProduct(id: String, completion: @escaping (_ result: Result<Product, Error>) -> Void)
    func fetchProducts(from: Int, limit: Int, completion: @escaping (_ result: Result<Page<Product>, Error>) -> Void)
}
