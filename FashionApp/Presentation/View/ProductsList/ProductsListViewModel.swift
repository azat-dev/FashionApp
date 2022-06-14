//
//  ProductsListViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit
import Alamofire

struct CellsData {
    var total: Int
    var items: [Int: ProductCellViewModel]
    var updatedItems: [Int]
}

enum PageState {
    case loading
    case loaded
}

// MARK: - Protocols

typealias ProductsListCoordinator = OpeningProduct

protocol ProductsListViewModelInput {
    
    func loadPage(at: Int)
    func reload()
    func openProduct(at: Int)
}

protocol ProductsListViewModelOutput {
    
    var cells: Observable<CellsData> { get }
    var isLoading: Observable<Bool> { get }
    var connectionError: Observable<Bool> { get }
    
    func cellViewModel(at: Int) -> ProductCellViewModel?
}

protocol ProductsListViewModel: ProductsListViewModelInput & ProductsListViewModelOutput {
    
}

// MARK: - Implementation

final class DefaultProductsListViewModel: ProductsListViewModel {
    
    var cells = Observable(CellsData(total: 0, items: [:], updatedItems: []))
    var isLoading = Observable(true)
    var connectionError = Observable(false)
    
    private let coordinator: ProductsListCoordinator
    private let pageSize = 10
    private var statesOfPages = [Int: PageState]()
    private var pagesQueue = OperationQueue()
    
    private var productsRepository: ProductsRepository
    private var imagesRepository: ImagesRepository
    
    private var loadImage: LoadImageFunction!
    
    init(productsRepository: ProductsRepository, imagesRepository: ImagesRepository, coordinator: ProductsListCoordinator) {
        pagesQueue = OperationQueue()
        pagesQueue.maxConcurrentOperationCount = 5
        
        self.productsRepository = productsRepository
        self.imagesRepository = imagesRepository
        self.coordinator = coordinator
    }
    
    private func page(at index: Int) -> Int {
        return (index - index % pageSize) / pageSize
    }
    
    func cellViewModel(at index: Int) -> ProductCellViewModel? {
        let loadingViewModel = DefaultProductCellViewModel(product: nil, imagesRepository: imagesRepository)
        
        guard index < cells.value.items.count else {
            return loadingViewModel
        }
        
        return cells.value.items[index] ?? loadingViewModel
    }
    
    private func product(at index: Int) -> Product? {
        let cellViewModel = cellViewModel(at: index)
        return cellViewModel?.getProduct()
    }
    
    func reload() {
        isLoading.value = true
        connectionError.value = false
        
        loadPage(at: 0)
    }
    
    func openProduct(at index: Int) {
        
        guard
            index < cells.value.items.count,
            let cellViewModel = cells.value.items[index],
            let product = cellViewModel.getProduct()
        else {
            return
        }
        
        coordinator.openProduct(productId: product.id)
    }
}

// MARK: - Networking

extension DefaultProductsListViewModel {
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
            
            
            newCells.items[cellIndex] = DefaultProductCellViewModel(
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
