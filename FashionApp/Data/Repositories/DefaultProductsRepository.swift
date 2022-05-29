//
//  DefaultProductsRepository.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 22.05.22.
//

import Foundation

final class DefaultProductsRepository {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension DefaultProductsRepository: ProductsRepository {
    func fetchProduct(id: String, completion: @escaping (Result<Product, Error>) -> Void) {
        networkManager.getItem(endpoint: .products, id: id) { (result: Result<Product, Error>) -> Void in
            completion(result)
        }
    }
    
    func fetchProducts(from: Int, limit: Int, completion: @escaping (Result<Page<Product>, Error>) -> Void) {
        networkManager.getItems(endpoint: .products, from: from, limit: limit) {
            (_ result: Result<ResponseGetItems<Product>, Error>) -> Void in
            
            if case .failure(let error) = result {
                completion(.failure(error))
                return
            }
            
            guard case .success(let response) = result else {
                let error = NSError(domain: "No Response", code: 0)
                completion(.failure(error))
                return
            }

            let data = Page(
                total: response.total,
                items: response.items
            )

            completion(.success(data))
        }
    }
}
