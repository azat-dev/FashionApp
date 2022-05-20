//
//  ViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 22.02.2022.
//

import UIKit

typealias ProductListViewControllerStyled = ProductsListViewController<
    ProductsListViewControllerLayout, ProductsListViewControllerStyles
>

class ProductsListViewController<
    Layout: ProductsListViewControllerLayoutable,
    Styles: ProductsListViewControllerStylable
>: UIViewController, UICollectionViewDelegate {
    
    private var networkRepository: NetworkRepository!
    
    private var collectionView: UICollectionView!
    private var activityIndicator = UIActivityIndicatorView()
    private lazy var connectionErrorView = {
        return ConnectionErrorViewStyled()
    } ()
    
    private lazy var dataSource: DataSource = {
        return DataSource(viewModel: viewModel)
    } ()
    
    private lazy var prefetchDelegate: PrefetchDelegate = {
        return PrefetchDelegate(viewModel: viewModel)
    } ()
    
    var viewModel: ProductListViewModel! {
        didSet {
            bindViewModel()
        }
    }
        
    init(viewModel: ProductListViewModel, networkRepository: NetworkRepository) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.networkRepository = networkRepository
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        guard let productViewModel = viewModel.getProductViewModel(at: indexPath.item) else {
            return
        }
        
        let vc = ProductDetailsViewControllerStyled(viewModel: productViewModel)
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
            ProductCellStyled.self,
            forCellWithReuseIdentifier: ProductCellStyled.reuseIdentifier
        )
        collectionView.register(
            ProductCellRoundedStyled.self,
            forCellWithReuseIdentifier: ProductCellRoundedStyled.reuseIdentifier
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
    private func hideConnectionErrorView() {
        connectionErrorView.removeFromSuperview()
    }
    
    private func showConnectionErrorView() {
        view.addSubview(connectionErrorView)
        connectionErrorView.onReload = { [weak self] in
            self?.collectionView.scrollToItem(
                at: IndexPath(item: 0, section: 0),
                at: .top,
                animated: false
            )
            
            self?.viewModel.reload()
        }
        
        Layout.apply(view: view, connectionErrorView: connectionErrorView)
    }

    private func updateActivityIndicator() {
        let isLoading = viewModel.isLoading.value
        let connectionError = viewModel.connectionError.value
        
        let isVisible = isLoading && !connectionError
        activityIndicator.isHidden = !isVisible
        
        if isVisible {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    private func updateConnectionErrorView() {
        let connectionError = viewModel.connectionError.value
        
        if connectionError {
            showConnectionErrorView()
        } else {
            hideConnectionErrorView()
        }
    }
    
    private func updateCollectionView() {
        let connectionError = viewModel.connectionError.value
        let isLoading = viewModel.isLoading.value
        let isVisible = !connectionError && !isLoading
        
        collectionView.isHidden = !isVisible
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { isLoading, _ in
            self.updateActivityIndicator()
            self.updateConnectionErrorView()
            self.updateCollectionView()
        }
        
        viewModel.connectionError.bind { connectionError, _ in
            self.updateActivityIndicator()
            self.updateConnectionErrorView()
            self.updateCollectionView()
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
            let reuseIdentifier = isRounded ? ProductCellRoundedStyled.reuseIdentifier : ProductCellStyled.reuseIdentifier
            
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
            for index in indexPaths {
                viewModel.loadPage(at: index.item)
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        }
    }
}
