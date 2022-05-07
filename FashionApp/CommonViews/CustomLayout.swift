//
//  CustomLayout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 01.03.2022.
//

import UIKit

class CustomLayout: UICollectionViewLayout {
    struct LayoutParams {
        var numberOfColumns: Int
        var horizontalSpacing: CGFloat
        var verticalSpacing: CGFloat
        var cellWidth: CGFloat
        var cellsHeights: [CGFloat]
        var insets: UIEdgeInsets
    }
    
    typealias CalculateLayoutParams = (CGSize) -> LayoutParams
    var prepareLayoutParams: CalculateLayoutParams!
    
    private var contentBounds: CGRect = .zero
    private var collectionViewSize: CGSize!
    
    private var layoutParams: LayoutParams!
    private var cachedAttributes: [UICollectionViewLayoutAttributes]!
    
    private func getColumnOffsetsX() -> [CGFloat] {
        var result = [CGFloat]()
        var columnOffset: CGFloat = layoutParams.insets.right
        
        for _ in 0..<layoutParams.numberOfColumns {
            result.append(columnOffset)
            columnOffset += layoutParams.cellWidth + layoutParams.verticalSpacing
        }
        
        return result
    }
    
    private func updateCachedAttributes() {
        
        cachedAttributes = []
        contentBounds = .zero
        
        var offsetsY = Array(
            repeating: layoutParams.insets.top,
            count: layoutParams.numberOfColumns
        )
        
        let columnWithMinOffsetY = { () -> Int in
            var column = 0
            var minOffsetY: CGFloat?
            
            for (currentColumn, offsetY) in offsetsY.enumerated() {
                if minOffsetY == nil || offsetY < minOffsetY! {
                    minOffsetY = offsetY
                    column = currentColumn
                }
            }
            
            return column
        }
        
        var index = 0
        var cellHeightIndex = 0
        let columnsOffsetsX = getColumnOffsetsX()
        let numberOfCells = collectionView?.numberOfItems(inSection: 0) ?? 0
        
        while true {
            for cellHeight in layoutParams.cellsHeights {
                if index >= numberOfCells {
                    contentBounds = CGRect(
                        x: contentBounds.minX,
                        y: contentBounds.minY,
                        width: contentBounds.width,
                        height: contentBounds.height + layoutParams.insets.bottom
                    )
                    return
                }
                
                let column = columnWithMinOffsetY()
                let columnOffset = columnsOffsetsX[column]
                
                let cellAttributes = UICollectionViewLayoutAttributes(
                    forCellWith: IndexPath(item: index, section: 0)
                )
                
                let y = offsetsY[column]
                
                cellAttributes.frame = CGRect(
                    x: columnOffset,
                    y: y,
                    width: layoutParams.cellWidth,
                    height: cellHeight
                )
                
                offsetsY[column] = y + cellHeight + layoutParams.verticalSpacing
                index += 1
                cellHeightIndex += 1
                
                if cellHeightIndex >= layoutParams.cellsHeights.count {
                    cellHeightIndex = 0
                }
                
                cachedAttributes.append(cellAttributes)
                contentBounds = contentBounds.union(cellAttributes.frame)
            }
        }
    }
    
    override func prepare() {
        super.prepare()
        
        collectionViewSize = collectionView!.bounds.size
        layoutParams = prepareLayoutParams(collectionViewSize)
        
        updateCachedAttributes()
    }
    
    override var collectionViewContentSize: CGSize {
        contentBounds.size
    }
    
    func getCellAttributes(index: Int) -> UICollectionViewLayoutAttributes {
        cachedAttributes[index]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return getCellAttributes(index: indexPath.item)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        let lastIndex = cachedAttributes.count - 1
        
        guard
            let firstMatchIndex = binSearch(rect, start: 0, end: lastIndex)
        else {
            return attributesArray
        }

        for index in firstMatchIndex...lastIndex {
            let cellAttributes = getCellAttributes(index: index)
            if rect.intersects(cellAttributes.frame) {
                attributesArray.append(cellAttributes)
            } else {
                break
            }
        }

        for index in stride(from: firstMatchIndex - 1, through: 0, by: -1) {
            let cellAttributes = getCellAttributes(index: index)
            if rect.intersects(cellAttributes.frame) {
                attributesArray.append(cellAttributes)
            } else {
                break
            }
        }
        
        return attributesArray
    }
    
    // Perform a binary search on the cached attributes array.
    func binSearch(_ rect: CGRect, start: Int, end: Int) -> Int? {
        if end < start {
            return nil
        }
        
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
