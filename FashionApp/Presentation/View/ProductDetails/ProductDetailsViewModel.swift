//
//  ProductDetailsViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit

enum LoadingState {
    case initial
    case loading
    case loaded
    case failed
}

// MARK: - Interfaces

typealias ProductDetailsCoordinator = OpeningProduct & OpeningProductFullScreenImage & GoingBack

protocol ProductDetailsViewModelOutput {
    var state: Observable<LoadingState> { get }
    var title: Observable<String> { get }
    var brand: Observable<String> { get }
    var description: Observable<String> { get }
    var isDescriptionButtonVisible: Observable<Bool> { get }
    var image: AsyncImageViewModel { get }
    var productId: String { get }
}

protocol ProductDetailsViewModelInput {
    func load()
    func openFullscreenImage()
    func goBack()
}

protocol ProductDetailsViewModel: ProductDetailsViewModelOutput & ProductDetailsViewModelInput {}

// MARK: - Implementation

class DefaultProductDetailsViewModel: ProductDetailsViewModel {

    private var product: Observable<Product?> = Observable(nil)
    
    private (set) var productId: String
    private let productsRepository: ProductsRepository
    private let imagesRepository: ImagesRepository
    private let coordinator: ProductDetailsCoordinator
    
    var state = Observable(LoadingState.initial)
    var title = Observable("Some long title stub")
    var brand = Observable("Some brand")
    var description = Observable("Loading description")
    var isDescriptionButtonVisible = Observable(false)
    var image: AsyncImageViewModel
    
    
    init(
        productId: String,
        productsRepository: ProductsRepository,
        imagesRepository: ImagesRepository,
        coordinator: ProductDetailsCoordinator
    ) {
        
        self.productsRepository = productsRepository
        self.imagesRepository = imagesRepository
        self.coordinator = coordinator
        
        self.image = AsyncImageViewModel(imagesRepository: imagesRepository)
        
        self.state.value = .initial
        self.productId = productId
        
        self.product.observe(on: self) { [weak self] product in
            self?.update(from: product)
        }
    }
    
    func load() {
        
        self.state.value = .loading
        
        productsRepository.fetchProduct(id: productId) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .failure(_):
                self.state.value = .failed
            case .success(let product):
                self.product.value = product
                self.state.value = .loaded
            }
        }
    }
    
    //    init(product: Product, loadImage: @escaping LoadImageFunction) {
    //
    //        self.image.didLoadImage = { [weak self] image in
    //            DispatchQueue.main.async {
    //                self?.loadedImage.value = image
    //                self?.isDescriptionButtonVisible.value = image != nil
    //            }
    //        }
    //    }
    
    private func update(from product: Product?) {
        
        guard let product = product else {
            self.state.value = .loading
            return
        }
        
        self.title.value = product.name
        self.brand.value = "FROM \(product.brand)"
        self.description.value = product.description
        
        //        self.image.loadImage.value = loadImage
        self.image.url.value = product.image
        self.state.value = .loaded
    }
    
    
    func addToCart() {
        
    }
    
    func openProduct() {
        coordinator.openProduct(productId: productId)
    }
    
    func goBack() {
        coordinator.goBack()
    }
    
    func openFullscreenImage() {
        
        guard
            let product = product.value,
            let image = image.image.value
        else {
            return
        }
        
        coordinator.openProductFullScreenImage(
            product: product,
            image: image
        )
    }
}
