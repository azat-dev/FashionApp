//
//  CustomLayout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 01.03.2022.
//

import UIKit

class CustomLayout: UICollectionViewLayout {
    typealias CalculateItemSize = (CGSize) -> CGSize
    
    var insets: UIEdgeInsets = .zero
    var verticalSpacing: CGFloat = .zero
    var itemOffset: CGFloat = 80
    
    var prepareItemSize: CalculateItemSize!
    
    private var contentBounds: CGRect = .zero
    private var numberOfColumns = 1
    private var itemSize: CGSize!
    private var collectionViewSize: CGSize!
    private var horizontalSpacing: CGFloat!
    
    var lastIndex: Int {
        let count = collectionView!.numberOfItems(inSection: 0)
        return count == 0 ? count : count - 1
    }
    
    override func prepare() {
        super.prepare()
        
        collectionViewSize = collectionView!.bounds.size
        itemSize = prepareItemSize(collectionViewSize)
        
        let count = collectionView?.numberOfItems(inSection: 0)
        numberOfColumns = Int(collectionViewSize.width / itemSize.width)
        contentBounds = CGRect(origin: .zero, size: collectionView!.bounds.size)
        
        horizontalSpacing = collectionViewSize.width - insets.left - insets.right - CGFloat(numberOfColumns) * itemSize.width
        
        if count == 0 {
            return
        }
        
        let lastPosition = getPosition(index: lastIndex)
        let lastRowFloat = CGFloat(lastPosition.row)
        
        contentBounds = CGRect(
            x: 0,
            y: 0,
            width: collectionViewSize.width,
            height: insets.top + (lastRowFloat + 1) * itemSize.height + lastRowFloat * verticalSpacing + itemOffset + insets.bottom
        )
        
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
    
    func getCellAttributes(index: Int) -> UICollectionViewLayoutAttributes {
        let attributes = UICollectionViewLayoutAttributes(
            forCellWith: IndexPath(row: index, section: 0)
        )
        
        let position = getPosition(index: index)
        var offset: CGFloat = 0
        
        if (position.column + 1) % 2 != 0 {
            offset = itemOffset
        }
        
        let rect = CGRect(
            x: insets.left + CGFloat(position.column) * itemSize.width + horizontalSpacing * CGFloat(position.column),
            y: insets.top + CGFloat(position.row) * itemSize.height + CGFloat(position.row) * verticalSpacing + offset,
            width: itemSize.width,
            height: itemSize.height
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
        return getCellAttributes(index: indexPath.row)
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
        
        let firstItems = stride(from: firstMatchIndex, through: 0, by: -1).map { getCellAttributes(index: $0) }
        
        for attributes in firstItems {
            guard attributes.frame.maxY >= rect.minY else { break }
            attributesArray.append(attributes)
        }
        
        let lastItems = (firstMatchIndex...lastIndex).map { getCellAttributes(index: $0) }
        
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
        let attr = getCellAttributes(index: mid)
        
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
