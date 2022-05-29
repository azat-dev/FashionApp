//
//  NetworkRepository.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 20.05.22.
//

import Foundation
import Alamofire
import UIKit

// MARK: - Interfaces

struct ResponseGetItems<Item: Decodable>: Decodable {
    var total: Int
    var items: [Item]
}

enum Endpoint: String, CaseIterable {
    case products = "products"
}

protocol NetworkManager {
    
    var baseUrl: String { get }
    
    func getItems<Item: Decodable>(
        endpoint: Endpoint,
        from: Int,
        limit: Int,
        completion: @escaping (_ result: Result<ResponseGetItems<Item>, Error>) -> Void
    )
    
    func getItem<Item: Decodable>(
        endpoint: Endpoint,
        id: String,
        completion: @escaping (Result<Item, Error>) -> Void
    )
    
    func loadImage(
        url: String,
        size: Size?,
        completion: @escaping (_ result: Result<Data, Error>) -> Void,
        progress: ((Double) -> Void)?
    )
}

// MARK: - Implementations

class DefaultNetworkManager: NetworkManager {
    
    private(set) var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
}

extension DefaultNetworkManager {
    func getItems<Item: Decodable>(
        endpoint: Endpoint,
        from: Int,
        limit: Int,
        completion: @escaping (_ result: Result<ResponseGetItems<Item>, Error>) -> Void
    ) {
        
        let url = "\(baseUrl)/\(endpoint)?from=\(from)&limit=\(limit)"
            
        AF.request(url)
            .validate()
            .responseDecodable { (response: DataResponse<ResponseGetItems<Item>, AFError>) -> Void in
                
                switch response.result {
                case .failure(let error):
                    let nsError = NSError(domain: "", code: error.responseCode ?? 0)
                    completion(.failure(nsError))
                case .success(let result):
                    completion(.success(result))
                }
            }
    }
    
    func getItem<Item: Decodable>(endpoint: Endpoint, id: String, completion: @escaping (Result<Item, Error>) -> Void) {
        let url = "\(baseUrl)/\(endpoint)/\(id)"
        
        AF.request(url)
            .validate()
            .responseDecodable { (response: DataResponse<Item, AFError>) -> Void in
                
                switch response.result {
                case .failure(let error):
                    let nsError = NSError(domain: "", code: error.responseCode ?? 0)
                    completion(.failure(nsError))
                case .success(let result):
                    completion(.success(result))
                }
            }
            
    }
    
    func loadImage(
        url: String,
        size: Size?,
        completion: @escaping (_ result: Result<Data, Error>) -> Void,
        progress: ((Double) -> Void)? = nil
    ) {
        
        AF.request(url)
            .downloadProgress(closure: { progressData in
                progress?(progressData.fractionCompleted)
            })
            .validate()
            .responseData { response in
                
                switch response.result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    completion(.success(data))
                }
            }
    }
}
