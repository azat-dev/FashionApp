//
//  AppDIContainer.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 29.05.22.
//

import Foundation
import UIKit

class AppDIContainer {
    
    func makePriceTagViewModel(product: Product, point: CGPoint) -> PriceTagViewModel {
        return DefaultPriceTagViewModel(product: product, point: point)
    }
    
    func makeNetworkManager() -> NetworkManager {
        return DefaultNetworkManager(baseUrl: "")
    }
    
    func makeProductsRepository() -> ProductsRepository {
        return DefaultProductsRepository(networkManager: makeNetworkManager())
    }
}
