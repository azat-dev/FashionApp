//
//  ProductListViewControllerLayout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit

// MARK: - Layout
extension ProductsListViewController {
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
    
    func layout(
        collectionView: UICollectionView
    ) {
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func isRoundedCell(index: IndexPath) -> Bool {
        let interval = cellsPatterns.count
        
        for (patternOffset, cellPattern) in cellsPatterns.enumerated() {
            if !cellPattern.isRounded {
                continue
            }
            
            if (index.row - patternOffset) % interval == 0 {
                return true
            }
        }
        
        return false
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = CustomLayout()
        let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        layout.prepareLayoutParams = {
            [unowned self] collectionViewSize in
            
            let width = (collectionViewSize.width - insets.left - CGFloat(self.numberOfColumns - 1) * self.horizontalSpacing - insets.right) / CGFloat(numberOfColumns)
            
            return CustomLayout.LayoutParams(
                numberOfColumns: self.numberOfColumns,
                horizontalSpacing: self.horizontalSpacing,
                verticalSpacing: self.verticalSpacing,
                cellWidth: width,
                cellsHeights: self.cellsPatterns.map {
                    cellPattern in
                    cellPattern.ratio * width
                },
                insets: insets
            )
        }
        
        return layout
    }
}
