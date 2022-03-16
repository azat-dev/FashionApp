//
//  ViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 22.02.2022.
//

import UIKit


class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var data: [Product] = [
        Product(id: "1", brand: "NIKE", name: "Fleming Jacket", price: 450),
        Product(id: "2", brand: "NIKE", name: "Fleming Jacket", price: 450),
        Product(id: "3", brand: "NIKE", name: "Fleming Jacket", price: 450),
        Product(id: "4", brand: "NIKE", name: "Fleming Jacket", price: 450),
        Product(id: "5", brand: "NIKE", name: "Fleming Jacket", price: 450),
        Product(id: "6", brand: "NIKE", name: "Fleming Jacket", price: 450)
    ]
    
    private var cellRegistration: UICollectionView.CellRegistration<ProductCell, Product>!
    private var roundedCellRegistration: UICollectionView.CellRegistration<ProductCellRounded, Product>!
    
    private var cellsPatterns = [
        (ratio: 2.0, isRounded: false),
        (ratio: 1.8, isRounded: true),
        (ratio: 1.8, isRounded: false),
        (ratio: 2, isRounded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        cellRegistration = {
            UICollectionView.CellRegistration(
                handler: {
                    cell, indexPath, product in
                    cell.product = product
                }
            )
        } ()
        
        roundedCellRegistration = {
            UICollectionView.CellRegistration(
                handler: {
                    cell, indexPath, product in
                    cell.product = product
                }
            )
        } ()
        
        let layoutWithoutSpace = UICollectionViewFlowLayout()
        
        layoutWithoutSpace.scrollDirection = .vertical
        layoutWithoutSpace.minimumInteritemSpacing = 0
        layoutWithoutSpace.minimumLineSpacing = 0
        
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createLayout()
        )

        
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        
        collectionView.register(
            ProductCell.self,
            forCellWithReuseIdentifier: ProductCell.reuseIdentifier
        )
        collectionView.register(
            ProductCellRounded.self,
            forCellWithReuseIdentifier: ProductCell.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        view.addSubview(collectionView)
    }
}

extension ViewController: UICollectionViewDataSource {
    
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isRoundedCell(index: indexPath) {
            return collectionView.dequeueConfiguredReusableCell(
                using: roundedCellRegistration,
                for: indexPath,
                item: data[indexPath.row]
            )
        }
        
        return collectionView.dequeueConfiguredReusableCell(
            using: cellRegistration,
            for: indexPath,
            item: data[indexPath.row]
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = CustomLayout()
        
        let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        layout.prepareLayoutParams = { collectionViewSize in
            
            let numberOfColumns = 2
            let horizontalSpacing: CGFloat = 20
            let ratio: CGFloat = 1.5
            let verticalSpacing: CGFloat = 20
            
            let width = (collectionViewSize.width - insets.left - CGFloat(numberOfColumns - 1) * horizontalSpacing - insets.right) / CGFloat(numberOfColumns)
            
            return CustomLayout.LayoutParams(
                numberOfColumns: numberOfColumns,
                horizontalSpacing: horizontalSpacing,
                verticalSpacing: verticalSpacing,
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
