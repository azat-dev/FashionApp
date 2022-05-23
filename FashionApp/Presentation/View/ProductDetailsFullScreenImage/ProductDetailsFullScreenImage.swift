//
//  ProductDetailsFullScreenImage.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 07.04.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

typealias ProductDetailsFullScreenImageViewControllerStyled = ProductDetailsFullScreenImage<ProductDetailsFullScreenImageLayout, ProductDetailsFullScreenImageStyles>

class ProductDetailsFullScreenImage<Layout: ProductDetailsFullScreenImageLayout, Styles: ProductDetailsFullScreenImageStylable>: UIViewController {
    
    private(set) var imageView = UIImageViewAligned()
    private var backButton = UIButton()
    private var buyButton = UIButton()
    private var priceTags = [PriceTagStyled]()
    
    var viewModel: ProductViewModel! {
        didSet {
            setupViews()
            bindViewModel()
        }
    }

    init(viewModel: ProductViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupViews()
        bindViewModel()
        layout()
        style()
    }
    
    @objc
    private func goBack() {
        guard let navigationController = navigationController else {
            dismiss(animated: true)
            return
        }
        
        
        navigationController.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addPriceTags()
        animatePriceTags()
    }
}

// MARK: - Setup views

extension ProductDetailsFullScreenImage {
    private func setupViews() {
        
        backButton.addTarget(self, action: #selector(Self.goBack), for: .touchUpInside)
        buyButton.addTarget(self, action: #selector(Self.goBack), for: .touchUpInside)
        imageView.tag = 1111
        view.addSubview(imageView)
        view.addSubview(buyButton)
        view.addSubview(backButton)
    }
}

extension ProductDetailsFullScreenImage {
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

extension ProductDetailsFullScreenImage {
    private func bindViewModel() {
        viewModel?.loadedImage.observe(on: self) { [weak self] newImage in
            self?.imageView.image = newImage?.cropAlpha()
        }
    }
}

// MARK: - Styles

extension ProductDetailsFullScreenImage {
    private func style() {
        Styles.apply(view: view)
        Styles.apply(backButton: backButton)
        Styles.apply(imageView: imageView)
        Styles.apply(buyButton: buyButton)
    }
}

// MARK: - Layout

extension ProductDetailsFullScreenImage {
    private func layout() {
        Layout.apply(
            view: view,
            backButton: backButton,
            imageView: imageView,
            buyButton: buyButton
        )
    }
}
