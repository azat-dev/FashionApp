//
//  ProductDetailsViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 16.03.2022.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

final class ProductDetailsViewController: UIViewController {
    
    private let styles: ProductDetailsViewControllerStyles!
    private let layout: ProductDetailsViewControllerLayout!
    
    private var backButton = UIButton(type: .system)
    private var scrollView = UIScrollView()
    private var titleLabel = UILabel()
    private var brandLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var cartButton = UIButton(type: .system)
    private var imageDescriptionButton = UIButton(type: .system)
    private var contentView = UIView()
    private var imageView = ImageViewShadowed()
    
    private var navigationDelegate = NavigationDelegate()
    
    var viewModel: ProductDetailsViewModel! {
        didSet {
            bind(to: viewModel)
        }
    }
    
    var openedImage: ImageViewShadowed?
    var openedImageFrame: CGRect? {
        guard let openedImage = openedImage else {
            return nil
        }
        
        return view.convert(openedImage.frame, to: nil)
    }
    
    init(
        viewModel: ProductDetailsViewModel,
        styles: ProductDetailsViewControllerStyles,
        layout: ProductDetailsViewControllerLayout
    ) {
        
        self.styles = styles
        self.layout = layout
        
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.load()
    }
    
    private func setup() {
        setupViews()
        style()
        applyLayout()
        bind(to: viewModel)
    }
    
    @objc
    private func goBack() {
        viewModel.goBack()
    }
    
    @objc
    private func openImage() {
        
        openedImage = imageView
        viewModel.openFullscreenImage()
    }
}

// MARK: - Set up views

extension ProductDetailsViewController {
    private func setupViews() {
        navigationController?.delegate = navigationDelegate
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.systemBackground
        
        backButton.addTarget(self, action: #selector(Self.goBack), for: .touchUpInside)
        imageDescriptionButton.addTarget(self, action: #selector(Self.openImage), for: .touchUpInside)
        contentView.addSubview(imageView)
        
        contentView.addSubview(imageDescriptionButton)
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(brandLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(cartButton)
        contentView.addSubview(backButton)
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
}

// MARK: - Bind ViewModel

extension ProductDetailsViewController {
    private func bind(to viewModel: ProductDetailsViewModel) {
        imageView.imageView.viewModel = viewModel.image
        
        viewModel.state.observe(on: self) { [weak self] state in
            self?.updateState(to: state)
        }
        
        viewModel.isDescriptionButtonVisible.observe(on: self) { [weak self] isVisible in
            self?.imageDescriptionButton.isHidden = !isVisible
        }
        
        viewModel.title.observe(on: self) { [weak self] title in
            self?.titleLabel.text = title
        }
        
        viewModel.brand.observe(on: self) { [weak self] brand in
            self?.brandLabel.text = brand
        }
        
        viewModel.description.observe(on: self) { [weak self] description in
            self?.descriptionLabel.text = description
        }
    }
    
    private func updateState(to state: LoadingState) {
        
        switch state {
        case .loaded:
            
            styles.apply(titleLabel: titleLabel)
            styles.apply(brandLabel: brandLabel)
            styles.apply(descriptionLabel: descriptionLabel)
            cartButton.isHidden = false
            imageDescriptionButton.isHidden = false
            
        case .loading, .initial, .failed:
            
            styles.apply(titleLabelLoading: titleLabel)
            styles.apply(brandLabelLoading: brandLabel)
            styles.apply(descriptionLabelLoading: descriptionLabel)
            cartButton.isHidden = true
            imageDescriptionButton.isHidden = true
        }
    }
}

// MARK: - Layout

extension ProductDetailsViewController {
    
    func applyLayout() {
        layout.apply(
            view: view,
            scrollView: scrollView,
            contentView: contentView,
            imageView: imageView,
            titleLabel: titleLabel,
            brandLabel: brandLabel,
            descriptionLabel: descriptionLabel,
            backButton: backButton,
            imageDescriptionButton: imageDescriptionButton,
            cartButton: cartButton
        )
    }
}

// MARK: - Assign styles

extension ProductDetailsViewController {
    func style() {
        styles.apply(scrollView: scrollView)
        styles.apply(contentView: contentView)
        styles.apply(imageView: imageView)
        styles.apply(titleLabel: titleLabel)
        styles.apply(brandLabel: brandLabel)
        styles.apply(descriptionLabel: descriptionLabel)
        styles.apply(cartButton: cartButton)
        styles.apply(backButton: backButton)
        styles.apply(imageDescriptionButton: imageDescriptionButton)
    }
}
