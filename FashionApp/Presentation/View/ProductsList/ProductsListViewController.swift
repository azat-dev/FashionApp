//
//  ViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 22.02.2022.
//

import UIKit

final class ProductsListViewController: UIViewController, UICollectionViewDelegate {
    
    private let styles: ProductsListViewControllerStyles!
    private let layout: ProductsListViewControllerLayout!
    
    private var collectionView: UICollectionView!
    private var activityIndicator = UIActivityIndicatorView()
    private lazy var connectionErrorView = {
        return ConnectionErrorViewStyled()
    } ()
    
    var viewModel: ProductsListViewModel! {
        didSet {
            bind(to: viewModel)
        }
    }
    
    init(
        viewModel: ProductsListViewModel,
        styles: ProductsListViewControllerStyles,
        layout: ProductsListViewControllerLayout
    ) {
        
        self.styles = styles
        self.layout = layout
        
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        applyLayout()
        bind(to: viewModel)
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
        
        viewModel.openProduct(at: indexPath.item)
    }
}

// MARK: - Set up views

extension ProductsListViewController {
    
    func setupViews() {
        
        collectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: layout.collectionViewLayout
        )
        
        collectionView.register(
            ProductCellStyled.self,
            forCellWithReuseIdentifier: ProductCellStyled.reuseIdentifier
        )
        collectionView.register(
            ProductCellRoundedStyled.self,
            forCellWithReuseIdentifier: ProductCellRoundedStyled.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        
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
        
        layout.apply(view: view, connectionErrorView: connectionErrorView)
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
    
    func bind(to viewModel: ProductsListViewModel) {
        viewModel.isLoading.observe(on: self) { [weak self] isLoading in
            self?.updateActivityIndicator()
            self?.updateConnectionErrorView()
            self?.updateCollectionView()
        }
        
        viewModel.connectionError.observe(on: self) { [weak self] connectionError in
            self?.updateActivityIndicator()
            self?.updateConnectionErrorView()
            self?.updateCollectionView()
        }
        
        viewModel.cells.observe(on: self) { [weak self] cells in
            guard let self = self else { return }
            
            let prevTotal = self.collectionView.numberOfItems(inSection: 0)
            if prevTotal != cells.total {
                self.collectionView.reloadData()
                return
            }
            
            self.collectionView.reloadItems(at: cells.updatedItems.map { IndexPath(item: $0, section: 0) })
        }
    }
}

// MARK: - Layout

extension ProductsListViewController {
    
    func applyLayout() {
        layout.apply(
            view: view,
            activityIndicator: activityIndicator,
            collectionView: collectionView
        )
    }
}

// MARK: - Styles

extension ProductsListViewController {
    
    func style() {
        styles.apply(view: view)
        styles.apply(collectionView: collectionView)
    }
}

// MARK: - DataSource

extension ProductsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let isRounded = layout.isRoundedCell(index: indexPath)
        let reuseIdentifier = isRounded ? ProductCellRoundedStyled.reuseIdentifier : ProductCellStyled.reuseIdentifier
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        )
        
        let cellViewModel = viewModel.cellViewModel(at: indexPath.item)
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

extension ProductsListViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            viewModel.loadPage(at: index.item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
    }
}
