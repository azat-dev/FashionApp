//
//  ProductListViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit


class ProductListViewModel {

    enum PageState {
        case loading
        case loaded
    }
    
    var items = Observable([Int: Product]())
    var numberOfItems = Observable(0)
    var isLoading = Observable(true)
    var connectionError = Observable(false)
    
    private let pageSize = 10
    private var statesOfPages = [Int: PageState]()
    private var pagesQueue = OperationQueue()
    
    init() {
        pagesQueue = OperationQueue()
        pagesQueue.maxConcurrentOperationCount = 5
    }
    
    private func page(at index: Int) -> Int {
        return (index - index % pageSize) / pageSize
    }
    
    func loadPage(at index: Int) {
        
        let page = page(at: index)
        let pageStart = page * pageSize
        
        guard statesOfPages[page] == nil else {
            return
        }
        
        statesOfPages[page] = .loading
        let loadOperation = LoadProductsOperation(from: pageStart, limit: pageSize)
        
        loadOperation.completionBlock = {
            
            guard
                loadOperation.error == nil,
                let loadedItems = loadOperation.items,
                let loadedTotal = loadOperation.total
            else {
                DispatchQueue.main.async {
                    self.connectionError.value = true
                    self.isLoading.value = false
                }
                return
            }
            
            DispatchQueue.main.async {
                var newItems = self.items.value
                
                for index in 0..<loadedItems.count {
                    let item = loadedItems[index]
                    newItems[pageStart + index] = item
                }
                
                self.statesOfPages[page] = .loading
                self.items.value = newItems
                self.numberOfItems.value = loadedTotal
                self.isLoading.value = false
            }
        }
        
        pagesQueue.addOperation(loadOperation)
    }
    
    func getProduct(at index: Int) -> Product? {
        return items.value[index]
    }
}

// MARK: - Load products
class LoadProductsOperation: AsyncOperation {
    struct ResponseProductsList: Codable {
        var total: Int
        var items: [Product]
    }

    let baseUrl = "http://localhost:8080/products"
    
    var from: Int
    var limit: Int
    var error: NSError?
    
    var total: Int?
    var items: [Product]?
    
    init(from: Int, limit: Int) {
        self.from = from
        self.limit = limit
    }
    
    override func main() {
        load(from: from, limit: limit) { error, response in
            if let error = error {
                self.error = error
                return
            }
            
            self.items = response?.items
            self.total = response?.total
        }
    }
    
    private func load(from: Int, limit: Int, completion: @escaping (_ error: NSError?, _ response: ResponseProductsList?) -> Void) {
    
        guard let url = URL(string: "\(baseUrl)?from=\(from)&limit=\(limit)") else {
            print("Wrong url string")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            defer { self.state = .finished }
            
            if let error = error {
                let err = NSError(
                    domain: "RequestError",
                    code: 0,
                    userInfo: ["error": error]
                )
                completion(err, nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(
                    domain: "WrongResponse",
                    code: 0,
                    userInfo: ["response": response as Any]
                )
                
                completion(error, nil)
                return
            }
            
            guard
                httpResponse.statusCode == 200,
                httpResponse.mimeType == "application/json"
            else {
                let error = NSError(
                    domain: "OperationFailed",
                    code: 0,
                    userInfo: ["httpResponse": httpResponse]
                )
                
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                let error = NSError(
                    domain: "WrongData",
                    code: 0,
                    userInfo: ["data": data as Any]
                )
                
                completion(error, nil)
                return
            }
            
            
            let decoder = JSONDecoder()
            let decodedResponse = try! decoder.decode(ResponseProductsList.self, from: data)
            completion(nil, decodedResponse)
        }
        
        dataTask.resume()
    }
}
