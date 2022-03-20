//
//  ViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 22.02.2022.
//

import UIKit


let defaultDescription = """
Short sleeve silk shirt with Hawaiian print. Classic
monogram, spread collar and corozo buttons.
100% silk. Made in Italy. With classic case
"""


class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var data: [Product] = [
        Product(id: "1", brand: "NIKE", name: "Comfort Jacket", price: 450, description: defaultDescription),
        Product(id: "2", brand: "NIKE", name: "Fleming Jacket", price: 450, description: defaultDescription),
        Product(id: "3", brand: "NIKE", name: "Fleming Jacket", price: 450, description: defaultDescription),
        Product(id: "4", brand: "NIKE", name: "Fleming Jacket", price: 450, description: defaultDescription),
        Product(id: "5", brand: "NIKE", name: "Fleming Jacket", price: 450, description: defaultDescription),
        Product(id: "6", brand: "NIKE", name: "Fleming Jacket", price: 450, description: defaultDescription)
    ]
    
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
        let layoutWithoutSpace = UICollectionViewFlowLayout()
        
        layoutWithoutSpace.scrollDirection = .vertical
        layoutWithoutSpace.minimumInteritemSpacing = 0
        layoutWithoutSpace.minimumLineSpacing = 0
        
        collectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: createLayout()
        )

        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        
        collectionView.register(
            ProductCell.self,
            forCellWithReuseIdentifier: ProductCell.reuseIdentifier
        )
        collectionView.register(
            ProductCellRounded.self,
            forCellWithReuseIdentifier: ProductCellRounded.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.delegate = self
        
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
        
        let reuseIdentifier = isRoundedCell(index: indexPath) ? ProductCellRounded.reuseIdentifier : ProductCell.reuseIdentifier
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as? ProductCell
        
        guard let cell = cell else {
            fatalError("Can't dequeue cell \(reuseIdentifier)")
        }

        let product = data[indexPath.row]
        cell.product = product
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - Collection View Layout Params
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

extension ViewController: UICollectionViewDelegate {
    override func viewDidAppear(_ animated: Bool) {
        let vc = ProductDetailsViewController()
        let product = data[0]

        vc.product = product
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let vc = ProductDetailsViewController()
        let product = data[indexPath.row]
        
        vc.product = product
        navigationController?.pushViewController(vc, animated: true)
    }
}
