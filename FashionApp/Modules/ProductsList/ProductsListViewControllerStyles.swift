//
//  ProductsListViewControllerStyles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 30.04.22.
//

import Foundation
import UIKit

protocol ProductsListViewControllerStylable {
    static func apply(view: UIView)
    static func apply(activityIndicator: UIActivityIndicatorView)
    static func apply(collectionView: UICollectionView)
}

class ProductsListViewControllerStyles: ProductsListViewControllerStylable {
    class func apply(view: UIView) {
        view.backgroundColor = .white
    }
    
    class func apply(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.style = .large
    }
    
    class func apply(collectionView: UICollectionView) {
    }
}
