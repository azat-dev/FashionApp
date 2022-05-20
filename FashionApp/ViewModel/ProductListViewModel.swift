//
//  ProductListViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit
import Alamofire

class ProductListViewModel {

    enum PageState {
        case loading
        case loaded
    }
    
    struct CellsData {
        var items = [Int: ProductCellViewModel]()
        var updatedItems = [Int]()
        var total = 0
    }
    
    var cells = Observable(CellsData())
    var isLoading = Observable(true)
    var connectionError = Observable(false)
    
    private let pageSize = 10
    private var statesOfPages = [Int: PageState]()
    private var pagesQueue = OperationQueue()
    private var networkRepository: NetworkRepository
    
    private var loadImage: LoadImageFunction!
    
    init(networkRepository: NetworkRepository) {
        pagesQueue = OperationQueue()
        pagesQueue.maxConcurrentOperationCount = 5
        self.networkRepository = networkRepository
        
        loadImage = { (url, size, completion, progress) in
            NetworkRepository.loadImage(
                url: networkRepository.baseUrl + url,
                size: size,
                completion: completion,
                progress: progress
            )
        }
    }
    
    private func page(at index: Int) -> Int {
        return (index - index % pageSize) / pageSize
    }
    
    func getCellViewModel(at index: Int) -> ProductCellViewModel? {
        let loadingViewModel = ProductCellViewModel(product: nil, loadImage: loadImage)
        
        guard index < cells.value.items.count else {
            return loadingViewModel
        }
        
        return cells.value.items[index] ?? loadingViewModel
    }
    
    func getProduct(at index: Int) -> Product? {
        let cellViewModel = getCellViewModel(at: index)
        return cellViewModel?.getProduct()
    }
    
    func reload() {
        isLoading.value = true
        connectionError.value = false
        
        loadPage(at: 0)
    }
}

// MARK: - Networking
extension ProductListViewModel {
    func loadPage(at index: Int) {
        
        let page = page(at: index)
        let pageStart = page * pageSize
        
        guard statesOfPages[page] == nil else {
            return
        }
        
        statesOfPages[page] = .loading
        
        networkRepository.getItems(
            endpoint: .products,
            from: pageStart,
            limit: pageSize
        ) {
            [weak self] (error: NSError?, response: NetworkRepository.ResponseGetItems<Product>?) -> Void in
            
            guard let self = self else {
                return
            }
        
            if let _ = error {
                self.connectionError.value = true
                self.isLoading.value = false
                return
            }
            
            guard let response = response else {
                self.connectionError.value = true
                self.isLoading.value = false
                return
            }

            var newCells = self.cells.value
            newCells.updatedItems = []
            
            for index in 0..<response.items.count {
                let product = response.items[index]
                let cellIndex = pageStart + index
                
                
                newCells.items[cellIndex] = ProductCellViewModel(
                    product: product,
                    loadImage: self.loadImage
                )
                newCells.updatedItems.append(cellIndex)
            }
            
            newCells.total = response.total
            self.statesOfPages[page] = .loading
            self.cells.value = newCells
            self.isLoading.value = false
        }
    }
}
