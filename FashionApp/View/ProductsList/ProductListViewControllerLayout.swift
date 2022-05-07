//
//  ProductListViewControllerLayout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit

protocol ProductsListViewControllerLayoutable {
    static func apply(view: UIView, activityIndicator: UIActivityIndicatorView, collectionView: UICollectionView)
    static func isRoundedCell(index: IndexPath) -> Bool
    static var collectionViewLayout: UICollectionViewLayout { get }
}

// MARK: - Layout
class ProductsListViewControllerLayout: ProductsListViewControllerLayoutable {
    private struct CellPattern {
        var ratio: CGFloat
        var isRounded: Bool
    }
    
    class private var cellsPatterns: [CellPattern] {
        [
            .init(ratio: 2.0, isRounded: false),
            .init(ratio: 1.8, isRounded: true),
            .init(ratio: 1.8, isRounded: false),
            .init(ratio: 2, isRounded: false)
        ]
    }
    
    class private var numberOfColumns: Int { 2 }
    class private var horizontalSpacing: CGFloat { 20 }
    class private var verticalSpacing: CGFloat { 20 }
    
    class func apply(
        view: UIView,
        activityIndicator: UIActivityIndicatorView,
        collectionView: UICollectionView
    ) {
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(collectionView)
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    class func isRoundedCell(index: IndexPath) -> Bool {
        let interval = cellsPatterns.count
        
        for (patternOffset, cellPattern) in cellsPatterns.enumerated() {
            if !cellPattern.isRounded {
                continue
            }
            
            if (index.item - patternOffset) % interval == 0 {
                return true
            }
        }
        
        return false
    }
    
    class var collectionViewLayout: UICollectionViewLayout {
        let layout = CustomLayout()
        let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        layout.prepareLayoutParams = { collectionViewSize in
            
            let width = (collectionViewSize.width - insets.left - CGFloat(numberOfColumns - 1) * horizontalSpacing - insets.right) / CGFloat(numberOfColumns)
            
            return CustomLayout.LayoutParams(
                numberOfColumns: numberOfColumns,
                horizontalSpacing: horizontalSpacing,
                verticalSpacing: verticalSpacing,
                cellWidth: width,
                cellsHeights: cellsPatterns.map {
                    cellPattern in
                    cellPattern.ratio * width
                },
                insets: insets
            )
        }
        
        return layout
    }
}
