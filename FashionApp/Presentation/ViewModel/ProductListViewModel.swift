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
    private var imagesRepository: ImagesRepository
    
    private var loadImage: LoadImageFunction!
    
    init(productsRepository: ProductsRepository, imagesRepository: ImagesRepository) {
        pagesQueue = OperationQueue()
        pagesQueue.maxConcurrentOperationCount = 5
        
        self.productsRepository = productsRepository
        self.imagesRepository = imagesRepository
    }
    
    private func page(at index: Int) -> Int {
        return (index - index % pageSize) / pageSize
    }
    
    func cellViewModel(at index: Int) -> ProductCellViewModel? {
        let loadingViewModel = ProductCellViewModel(product: nil, imagesRepository: imagesRepository)
        
        guard index < cells.value.items.count else {
            return loadingViewModel
        }
        
        return cells.value.items[index] ?? loadingViewModel
    }
    
    private func product(at index: Int) -> Product? {
        let cellViewModel = cellViewModel(at: index)
        return cellViewModel?.getProduct()
    }
    
    func productViewModel(at index: Int) -> ProductViewModel? {
        guard let product = product(at: index) else {
            return nil
        }
        
        let viewModel = ProductViewModel(
            productId: product.id,
            productsRepository: productsRepository,
            imagesRepository: imagesRepository
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
                imagesRepository: imagesRepository
            )
            newCells.updatedItems.append(cellIndex)
        }
        
        newCells.total = pageData.total
        self.statesOfPages[page] = .loading
        self.cells.value = newCells
        self.isLoading.value = false
    }
}
