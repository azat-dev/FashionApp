//
//  ViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 22.02.2022.
//

import UIKit


class ProductsListViewController: UIViewController {
    typealias Cell = ProductCell<ProductCellLayout, ProductCellStyles>
    typealias RoundedCell = ProductCellRounded<ProductCellLayout, ProductCellRoundedStyles>
    typealias DetailsViewController = ProductDetailsViewController<ProductDetailsViewControllerLayout, ProductDetailsViewControllerStyles>
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
//            let product = viewModel.getProduct(at: indexPath.row)
            let viewModel = ProductViewModel(product: product1)
            let vc = DetailsViewController(viewModel: viewModel)
            
            show(vc, sender: self)
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
            Cell.self,
            forCellWithReuseIdentifier: Cell.reuseIdentifier
        )
        collectionView.register(
            RoundedCell.self,
            forCellWithReuseIdentifier: RoundedCell.reuseIdentifier
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
        
        let isRounded = isRoundedCell(index: indexPath)
        let reuseIdentifier = isRounded ? RoundedCell.reuseIdentifier : Cell.reuseIdentifier
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        )
        
        
        let product = viewModel.getProduct(at: indexPath.row)
        let viewModel = ProductCellViewModel(product: product)
        
        (cell as? ProductCellWithViewModel)?.viewModel = viewModel
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
        let vc = DetailsViewController(viewModel: viewModel)
        
        show(vc, sender: self)
    }
}
