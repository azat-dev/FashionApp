//
//  ProductListViewControllerLayout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit

// MARK: - Interfaces

protocol ProductsListViewControllerLayout {
    
    func apply(view: UIView, activityIndicator: UIActivityIndicatorView, collectionView: UICollectionView)
    func isRoundedCell(index: IndexPath) -> Bool
    var collectionViewLayout: UICollectionViewLayout { get }
    func apply(view: UIView, connectionErrorView: ConnectionErrorViewStyled)
}

// MARK: - Implementations

struct DefaultProductsListViewControllerLayout: ProductsListViewControllerLayout {
    
    private struct CellPattern {
        var ratio: CGFloat
        var isRounded: Bool
    }
    
    private var cellsPatterns: [CellPattern] {
        [
            .init(ratio: 2.0, isRounded: false),
            .init(ratio: 1.8, isRounded: true),
            .init(ratio: 1.8, isRounded: false),
            .init(ratio: 2, isRounded: false)
        ]
    }
    
    private var numberOfColumns: Int { 2 }
    private var horizontalSpacing: CGFloat { 20 }
    private var verticalSpacing: CGFloat { 20 }
    
    func apply(
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
    
    func isRoundedCell(index: IndexPath) -> Bool {
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
    
    var collectionViewLayout: UICollectionViewLayout {
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
    
    func apply(view: UIView, connectionErrorView: ConnectionErrorViewStyled) {
        connectionErrorView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}
