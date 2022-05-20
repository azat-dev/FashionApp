//
//  NetworkRepository.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 20.05.22.
//

import Foundation
import Alamofire
import UIKit

class NetworkRepository {
    private(set) var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
}

extension NetworkRepository {
    struct ResponseGetItems<Item: Decodable>: Decodable {
        var total: Int
        var items: [Item]
    }

    enum Endpoint: String, CaseIterable {
        case products = "products"
    }
}

extension NetworkRepository {
    func getItems<Item: Decodable>(
        endpoint: Endpoint,
        from: Int,
        limit: Int,
        completion: @escaping (_ error: NSError?, _ response: ResponseGetItems<Item>?) -> Void
    ) {
        
        let url = "\(baseUrl)/\(endpoint)?from=\(from)&limit=\(limit)"
            
        AF.request(url)
            .validate()
            .responseDecodable { (response: DataResponse<ResponseGetItems<Item>, AFError>) -> Void in
                
                switch response.result {
                case .failure(let error):
                    let nsError = NSError(domain: "", code: error.responseCode ?? 0)
                    completion(nsError, nil)
                case .success(let result):
                    completion(nil, result)
                }
            }
    }
    
    static func loadImage(
        url: String,
        size: Size?,
        completion: @escaping (_ error: Error?, _ image: UIImage?) -> Void,
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
                    print("Error \(error)")
                    completion(nil, nil)
                    
                case .success(let data):
                    
                    guard let image = UIImage(data: data) else {
                        completion(nil, nil)
                        return
                    }
                    
                    completion(nil, image)
                }
            }
    }
}
