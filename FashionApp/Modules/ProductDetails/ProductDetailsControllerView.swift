//
//  ProductDetailsViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 16.03.2022.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

class ProductDetailsViewController<Layout: ProductDetailsViewLayoutable, Styles: ProductDetailsViewStylable>: UIViewController {
    
    private var backButton = UIButton(type: .system)
    private var scrollView = UIScrollView()
    private var imageShadow = ShadowView()
    private var imageContainer = ShapedView()
    private var imageView = UIImageViewAligned()
    private var titleLabel = UILabel()
    private var brandLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var cartButton = UIButton(type: .system)
    private var imageDescriptionButton = UIButton(type: .system)
    private var contentView = UIView()
    
    var viewModel: ProductViewModel!
    
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
        style()
        layout()
        bindViewModel()
    }
    
    @objc
    private func goBack() {
        guard let navigationController = navigationController else {
            dismiss(animated: true)
            return
        }
        
        
        navigationController.popViewController(animated: true)
    }
    
    @objc
    private func openImage() {
        
        let vc = ProductDetailsFullScreenImage<
            ProductDetailsFullScreenImageStyles,
            ProductDetailsFullScreenImageLayout
        >(viewModel: viewModel)
        
        show(vc, sender: self)
    }
}

// MARK: - Set up views
private extension ProductDetailsViewController {
    private func setupViews() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.systemBackground
        
        backButton.addTarget(self, action: #selector(Self.goBack), for: .touchUpInside)
        imageDescriptionButton.addTarget(self, action: #selector(Self.openImage), for: .touchUpInside)
        imageContainer.addSubview(imageView)
        imageShadow.addSubview(imageContainer)
        contentView.addSubview(imageShadow)
        
        contentView.addSubview(imageDescriptionButton)
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(brandLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(cartButton)
        imageContainer.addSubview(backButton)
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
}

// MARK: - Bind ViewModel
private extension ProductDetailsViewController {
    private func bindViewModel() {
        viewModel.image.bind {
            [weak self] in
            self?.imageView.image = $0
        }
        
        viewModel.title.bind {
            [weak self] in
            self?.titleLabel.text = $0
        }
        
        viewModel.brand.bind {
            [weak self] in
            self?.brandLabel.text = $0
        }
        
        viewModel.description.bind {
            [weak self] in
            self?.descriptionLabel.text = $0
        }
    }
}

// MARK: - Layout
private extension ProductDetailsViewController {
    func layout() {
        Layout.apply(
            view: view,
            scrollView: scrollView,
            contentView: contentView,
            imageShadow: imageShadow,
            imageContainer: imageContainer,
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
private extension ProductDetailsViewController {
    func style() {
        Styles.apply(scrollView: scrollView)
        Styles.apply(contentView: contentView)
        Styles.apply(imageShadow: imageShadow)
        Styles.apply(imageContainer: imageContainer)
        Styles.apply(imageView: imageView)
        Styles.apply(titleLabel: titleLabel)
        Styles.apply(brandLabel: brandLabel)
        Styles.apply(descriptionLabel: descriptionLabel)
        Styles.apply(cartButton: cartButton)
        Styles.apply(backButton: backButton)
        Styles.apply(imageDescriptionButton: imageDescriptionButton)
    }
}
