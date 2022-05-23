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
    private var productsRepository: ProductsRepository
    
    private var loadImage: LoadImageFunction!
    
    init(productsRepository: ProductsRepository) {
        pagesQueue = OperationQueue()
        pagesQueue.maxConcurrentOperationCount = 5
        self.productsRepository = productsRepository
        
        loadImage = { (url, size, completion, progress) in
            // FIXME: ADD LOAD IMAGE
            //            NetworkRepository.loadImage(
            //                url: networkRepository.baseUrl + url,
            //                size: size,
            //                completion: completion,
            //                progress: progress
            //            )
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
    
    private func product(at index: Int) -> Product? {
        let cellViewModel = getCellViewModel(at: index)
        return cellViewModel?.getProduct()
    }
    
    func viewModel(at index: Int) -> ProductViewModel? {
        guard let product = product(at: index) else {
            return nil
        }
        
        let viewModel = ProductViewModel(
            productId: product.id,
            productsRepository: productsRepository
        )
        return viewModel
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
        
        productsRepository.fetchProducts(from: pageStart, limit: pageSize) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .failure(_):
                self.connectionError.value = true
                self.isLoading.value = false
            case .success(let pageData):
                self.append(pageData: pageData, at: page)
            }
        }
    }
    
    private func append(pageData: Page<Product>, at page: Int) {
        let pageStart = page * pageSize
        var newCells = self.cells.value
        newCells.updatedItems = []
        
        for index in 0..<pageData.items.count {
            let product = pageData.items[index]
            let cellIndex = pageStart + index
            
            
            newCells.items[cellIndex] = ProductCellViewModel(
                product: product,
                loadImage: self.loadImage
            )
            newCells.updatedItems.append(cellIndex)
        }
        
        newCells.total = pageData.total
        self.statesOfPages[page] = .loading
        self.cells.value = newCells
        self.isLoading.value = false
    }
}
