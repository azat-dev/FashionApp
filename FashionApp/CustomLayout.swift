//
//  CustomLayout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 01.03.2022.
//

import UIKit

class CustomLayout: UICollectionViewLayout {
    var contentBounds: CGRect = .zero
    var minItemWidth: CGFloat = 100
    let horizontalSpacing: CGFloat = 10
    let verticalSpacing: CGFloat = 20
    let itemHeight: CGFloat = 300
    let itemOffset: CGFloat = 80
    var numberOfColumns = 1
    
    var lastIndex: Int {
        let count = collectionView!.numberOfItems(inSection: 0)
        return count == 0 ? count : count - 1
    }
    
    override func prepare() {
        super.prepare()
        
        let width = collectionView!.bounds.size.width
        
        minItemWidth = width / 2 - 20
        let count = collectionView?.numberOfItems(inSection: 0)
        numberOfColumns = Int(width / CGFloat(minItemWidth))
        
        contentBounds = CGRect(origin: .zero, size: collectionView!.bounds.size)
        
        if count == 0 {
            return
        }
        
        let firstAttributes = getAttributes(index: 0)
        contentBounds = contentBounds.union(firstAttributes.frame)
        
        if count == 1 {
            return
        }
        
        let lastAttributes = getAttributes(index: lastIndex)
        contentBounds = contentBounds.union(lastAttributes.frame)
        
    }
    
    override var collectionViewContentSize: CGSize {
        contentBounds.size
    }
    
    func getPosition(index: Int) -> (row: Int, column: Int) {
        let row = index / numberOfColumns
        return (
            row: row,
            column: index - row * numberOfColumns
        )
    }
    
    func getAttributes(index: Int) -> UICollectionViewLayoutAttributes {
        let attributes = UICollectionViewLayoutAttributes(
            forCellWith: IndexPath(row: index, section: 0)
        )
        
        let position = getPosition(index: index)
        let width = collectionView!.bounds.size.width
        
        var horizontalSpacing: CGFloat = 0
        if numberOfColumns > 1 {
            horizontalSpacing = (width - CGFloat(numberOfColumns) * minItemWidth) / CGFloat(numberOfColumns - 1)
        }
        
        var offset: CGFloat = 0
        
        if (position.column + 1) % 2 == 0 {
            offset = itemOffset
        }
        
        let rect = CGRect(
            x: CGFloat(position.column) * minItemWidth + horizontalSpacing * CGFloat(position.column),
            y: CGFloat(position.row) * itemHeight + CGFloat(position.row) * verticalSpacing + offset,
            width: minItemWidth,
            height: itemHeight
        )
        
        attributes.frame = rect
        
        return attributes
    }
    
    /// - Tag: ShouldInvalidateLayout
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }
    
    /// - Tag: LayoutAttributesForItem
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return getAttributes(index: indexPath.row)
    }
    
    /// - Tag: LayoutAttributesForElements
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        
        // Find any cell that sits within the query rect.
        guard
            let firstMatchIndex = binSearch(rect, start: 0, end: lastIndex)
        else {
            return attributesArray
        }
        
        // Starting from the match, loop up and down through the array until all the attributes
        // have been added within the query rect.
        
        let firstItems = stride(from: firstMatchIndex, through: 0, by: -1).map { getAttributes(index: $0) }
        
        for attributes in firstItems {
            guard attributes.frame.maxY >= rect.minY else { break }
            attributesArray.append(attributes)
        }
        
        let lastItems = (firstMatchIndex...lastIndex).map { getAttributes(index: $0) }
        
        for attributes in lastItems {
            guard attributes.frame.minY <= rect.maxY else { break }
            attributesArray.append(attributes)
        }
        
        return attributesArray
    }
    
    // Perform a binary search on the cached attributes array.
    func binSearch(_ rect: CGRect, start: Int, end: Int) -> Int? {
        if end < start { return nil }
        
        let mid = (start + end) / 2
        let attr = getAttributes(index: mid)
        
        if attr.frame.intersects(rect) {
            return mid
        } else {
            if attr.frame.maxY < rect.minY {
                return binSearch(rect, start: (mid + 1), end: end)
            } else {
                return binSearch(rect, start: start, end: (mid - 1))
            }
        }
    }
}
