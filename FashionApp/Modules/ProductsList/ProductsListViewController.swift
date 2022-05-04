//
//  ViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 22.02.2022.
//

import UIKit


class ProductsListViewController<
    Layout: ProductsListViewControllerLayoutable,
    Styles: ProductsListViewControllerStylable
>: UIViewController, UICollectionViewDelegate {
    
    typealias Cell = ProductCell<ProductCellLayout, ProductCellStyles>
    typealias RoundedCell = ProductCellRounded<ProductCellLayout, ProductCellRoundedStyles>
    
    typealias DetailsViewController = ProductDetailsViewController<ProductDetailsViewControllerLayout, ProductDetailsViewControllerStyles>
    
    private var collectionView: UICollectionView!
    private var activityIndicator = UIActivityIndicatorView()
    
    private lazy var dataSource: DataSource = {
        return DataSource(viewModel: viewModel)
    } ()
    
    private lazy var prefetchDelegate: PrefetchDelegate = {
        return PrefetchDelegate(viewModel: viewModel)
    } ()
    
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
        style()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadPage(at: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let product = viewModel.getProduct(at: indexPath.row) else {
            return
        }
        
        let viewModel = ProductViewModel(product: product)
        let vc = DetailsViewController(viewModel: viewModel)
        
        show(vc, sender: self)
    }
}

// MARK: - Set up views
extension ProductsListViewController {
    func setupViews() {
        
        collectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: Layout.collectionViewLayout
        )
        
        collectionView.register(
            Cell.self,
            forCellWithReuseIdentifier: Cell.reuseIdentifier
        )
        collectionView.register(
            RoundedCell.self,
            forCellWithReuseIdentifier: RoundedCell.reuseIdentifier
        )
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.prefetchDataSource = prefetchDelegate
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
}

// MARK: - Bind ViewModel
extension ProductsListViewController {
    func bindViewModel() {
        viewModel.isLoading.bind { isLoading, _ in
            self.activityIndicator.isHidden = !isLoading
            if isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
            
            self.collectionView.isHidden = isLoading
        }
        
        viewModel.items.bind { _, _ in
            self.collectionView.reloadData()
        }
        
        viewModel.numberOfItems.bind { _, _ in
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Layout
extension ProductsListViewController {
    func layout() {
        Layout.apply(
            view: view,
            activityIndicator: activityIndicator,
            collectionView: collectionView
        )
    }
}

// MARK: - Styles
extension ProductsListViewController {
    func style() {
        Styles.apply(view: view)
        Styles.apply(collectionView: collectionView)
    }
}

// MARK: - DataSource
extension ProductsListViewController {
    class DataSource: NSObject, UICollectionViewDataSource {
        var viewModel: ProductListViewModel
        
        init(viewModel: ProductListViewModel) {
            self.viewModel = viewModel
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let isRounded = Layout.isRoundedCell(index: indexPath)
            let reuseIdentifier = isRounded ? RoundedCell.reuseIdentifier : Cell.reuseIdentifier
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: reuseIdentifier,
                for: indexPath
            )
            
            
            let cellViewModel = viewModel.getCellViewModel(at: indexPath.row)
            (cell as? ProductCellWithViewModel)?.viewModel = cellViewModel
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.numberOfItems.value
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    }
}

extension ProductsListViewController {
    class PrefetchDelegate: NSObject, UICollectionViewDataSourcePrefetching {
        var viewModel: ProductListViewModel!
        
        init(viewModel: ProductListViewModel) {
            self.viewModel = viewModel
        }
        
        func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
            for index in indexPaths {
                viewModel.loadPage(at: index.row)
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        }
    }
}
