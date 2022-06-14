//
//  AppCoordinator.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 31.05.22.
//

import Foundation
import UIKit

// MARK: - Interfaces

protocol OpeningProduct {
    func openProduct(productId: String)
}

protocol OpeningProductFullScreenImage {
    func openProductFullScreenImage(product: Product, image: UIImage)
}

protocol GoingBack {
    func goBack()
}

protocol AppCoordinator: OpeningProduct, OpeningProductFullScreenImage, GoingBack, AnyObject {
    
    func start()
}

// MARK: - Implementations

final class DefaultAppCoordinator: AppCoordinator {

    private let window: UIWindow
    private let navigationController: UINavigationController
    
    private lazy var networkManager: NetworkManager = {
        return DefaultNetworkManager(baseUrl: "http://192.168.0.102:8080")
    } ()
    
    private lazy var productsRepository: ProductsRepository = {
        return DefaultProductsRepository(networkManager: networkManager)
    } ()
    
    private lazy var imagesRepository: ImagesRepository = {
        return DefaultImagesRepository(networkManager: networkManager)
    } ()

    private lazy var rootVC: ProductsListViewController = {
        let factory = ProductsListViewControllerFactory(
            coordinator: self,
            productsRepository: productsRepository,
            imagesRepository: imagesRepository
        )
        
        return factory.build()
    } ()
    
    init(window: UIWindow) {
        
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start() {
        
        navigationController.isNavigationBarHidden = false
        
        window.rootViewController = navigationController
        navigationController.pushViewController(rootVC, animated: false)
        window.makeKeyAndVisible()
    }
}

// MARK: - Actions

extension DefaultAppCoordinator {
    
    func openProduct(productId: String) {
        
        let factory = ProductDetailsViewControllerFactory(
            coordinator: self,
            productsRepository: productsRepository,
            imagesRepository: imagesRepository
        )
        
        let vc = factory.build(with: productId)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openProductFullScreenImage(product: Product, image: UIImage) {
        
        let factory = ProductDetailsFullScreenImageViewControllerFactory(coordinator: self)
        
        let vc = factory.build(with: .init(product: product, image: image))
        navigationController.pushViewController(vc, animated: true)

    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
