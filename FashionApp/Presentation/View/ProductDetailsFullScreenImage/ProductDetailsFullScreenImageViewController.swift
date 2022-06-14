//
//  ProductDetailsFullScreenImage.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 07.04.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

// MARK: - Implementations

final class ProductDetailsFullScreenImageViewController: UIViewController  {

    private let styles: ProductDetailsFullScreenImageViewControllerStyles!
    private let layout: ProductDetailsFullScreenImageViewControllerLayout!
    
    private(set) var imageView = UIImageViewAligned()
    private var backButton = UIButton()
    private var buyButton = UIButton()
    private var priceTags = [PriceTagStyled]()
    
    var viewModel: ProductDetailsFullScreenImageViewModel! {
        didSet {
            setupViews()
            bind(to: viewModel)
        }
    }

    init(
        viewModel: ProductDetailsFullScreenImageViewModel,
        styles: ProductDetailsFullScreenImageViewControllerStyles,
        layout: ProductDetailsFullScreenImageViewControllerLayout
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
    }
    
    private func setup() {
        setupViews()
        bind(to: viewModel)
        applyLayout()
        style()
    }
    
    @objc
    private func goBack() {
        viewModel.goBack()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addPriceTags()
        animatePriceTags()
    }
}

// MARK: - Setup views

extension ProductDetailsFullScreenImageViewController {
    private func setupViews() {
        
        backButton.addTarget(self, action: #selector(Self.goBack), for: .touchUpInside)
        buyButton.addTarget(self, action: #selector(Self.goBack), for: .touchUpInside)
        imageView.tag = 1111
        view.addSubview(imageView)
        view.addSubview(buyButton)
        view.addSubview(backButton)
    }
}

extension ProductDetailsFullScreenImageViewController {
    private func addPriceTags() {
//        let priceTag1 = PriceTagView(frame: .zero)
//        priceTag1.viewModel = PriceTagViewModel(
//            product: product1,
//            point: .init(x: 0.5, y: 0.5)
//        )
//        
//        priceTag1.center = .init(x: 100, y: 100)
//        view.addSubview(priceTag1)
//        
//        priceTags.append(priceTag1)
//        
//        let priceTag2 = PriceTagView(frame: .zero)
//
//        priceTag2.viewModel = PriceTagViewModel(
//            product: product1,
//            point: .init(x: 0.5, y: 0.7)
//        )
//        priceTag2.center = .init(x: 80, y: 300)
//        view.addSubview(priceTag2)
//        
//        priceTags.append(priceTag2)
    }
    
    private func animatePriceTags() {
        let delayStep: Double = 0.5
        var delay: Double = 0
        
        priceTags.forEach { priceTag in
            priceTag.animateAppearance(delay: delay)
            delay += delayStep
        }
    }
}


// MARK: - Bind ViewModel

extension ProductDetailsFullScreenImageViewController {
    private func bind(to viewModel: ProductDetailsFullScreenImageViewModel?) {
        viewModel?.image.observe(on: self) { [weak self] newImage in
            self?.imageView.image = newImage?.cropAlpha()
        }
    }
}

// MARK: - Styles

extension ProductDetailsFullScreenImageViewController {
    private func style() {
        styles.apply(view: view)
        styles.apply(backButton: backButton)
        styles.apply(imageView: imageView)
        styles.apply(buyButton: buyButton)
    }
}

// MARK: - Layout

extension ProductDetailsFullScreenImageViewController {
    private func applyLayout() {
        layout.apply(
            view: view,
            backButton: backButton,
            imageView: imageView,
            buyButton: buyButton
        )
    }
}
