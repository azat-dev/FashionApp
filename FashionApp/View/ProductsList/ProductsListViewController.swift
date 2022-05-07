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
    
//    override func viewWillAppear(_ animated: Bool) {
//        viewModel.loadPage(at: 0)
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        let maxY = collectionView.frame.maxY
        var maxIndex = 0
        
        for index in 0... {
            let cellAttributes = collectionView.layoutAttributesForItem(at: IndexPath(item: index, section: 0))
            
            guard let cellAttributes = cellAttributes else {
                maxIndex = 15
                break
            }

            maxIndex += 1
            if cellAttributes.frame.maxY > maxY {
                break
            }
        }
        
        for index in 0...maxIndex {
            viewModel.loadPage(at: index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let product = viewModel.getProduct(at: indexPath.item) else {
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
            
            self.collectionView.isOpaque = !isLoading
        }
        
        viewModel.cells.bind { cells, prevCells in
            if prevCells?.total != cells.total {
                self.collectionView.reloadData()
                return
            }
            
            self.collectionView.reloadItems(at: cells.updatedItems.map { IndexPath(item: $0, section: 0) })
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
            
            
            let cellViewModel = viewModel.getCellViewModel(at: indexPath.item)
            (cell as? ProductCellWithViewModel)?.viewModel = cellViewModel
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.cells.value.total
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
            print("Prefetch \(indexPaths)")
            for index in indexPaths {
                viewModel.loadPage(at: index.item)
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        }
    }
}
