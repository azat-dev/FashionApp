//
//  ViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 22.02.2022.
//

import UIKit

class ProductsListViewController: UIViewController {
    private var collectionView: UICollectionView!
    var viewModel: ProductListViewModel = ProductListViewModel() {
        didSet {
            bindViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layout()
        bindViewModel()
    }
}

// MARK: - Set up views
extension ProductsListViewController {
    func setupViews() {
        collectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: createLayout()
        )
        
        collectionView.register(
            ProductCell.self,
            forCellWithReuseIdentifier: ProductCell.reuseIdentifier
        )
        collectionView.register(
            ProductCellRounded.self,
            forCellWithReuseIdentifier: ProductCellRounded.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }
}

// MARK: - Bind ViewModel
extension ProductsListViewController {
    func bindViewModel() {
        
    }
}

// MARK: - Layout
extension ProductsListViewController {
    func layout() {
        layout(collectionView: collectionView)
    }
}

extension ProductsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = isRoundedCell(index: indexPath) ? ProductCellRounded.reuseIdentifier : ProductCell.reuseIdentifier
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as? ProductCell
        
        guard let cell = cell else {
            fatalError("Can't dequeue cell \(reuseIdentifier)")
        }

        let product = viewModel.getProduct(at: indexPath.row)
        cell.viewModel = ProductCellViewModel(product: product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ProductsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        
        let product = viewModel.getProduct(at: indexPath.row)
        let viewModel = ProductViewModel(product: product)
        let vc = ProductDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
