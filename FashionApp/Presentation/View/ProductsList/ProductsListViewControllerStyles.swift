//
//  ProductsListViewControllerStyles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 30.04.22.
//

import Foundation
import UIKit

// MARK: - Interfaces

protocol ProductsListViewControllerStylable {
    func apply(view: UIView)
    func apply(activityIndicator: UIActivityIndicatorView)
    func apply(collectionView: UICollectionView)
}

// MARK: - Implementations

class ProductsListViewControllerStyles: ProductsListViewControllerStylable {
    
    func apply(view: UIView) {
        view.backgroundColor = .white
    }
    
    func apply(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.style = .large
    }
    
    func apply(collectionView: UICollectionView) {
    }
}
