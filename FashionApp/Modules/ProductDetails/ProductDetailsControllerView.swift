//
//  ProductDetailsViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 16.03.2022.
//

import Foundation
import UIKit

class ProductDetailsViewController: UIViewController {
    
    private lazy var backButton = UIButton(type: .system)
    private lazy var scrollView = UIScrollView()
    private lazy var shapedImageView = ShapedImageView()
    private lazy var titleLabel = UILabel()
    private lazy var brandLabel = UILabel()
    private lazy var descritptionLabel = UILabel()
    private lazy var cartButton = UIButton(type: .system)
    private lazy var imageDescriptionButton = UIButton(type: .system)
    private lazy var contentView = UIView()
    
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
        setupViews()
        styleViews()
        layout()
        bindViewModel()
    }
    
    @objc
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Set up views
private extension ProductDetailsViewController {
    private func setupViews() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.systemBackground
        
        backButton.addTarget(self, action: #selector(Self.goBack), for: .touchUpInside)
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        shapedImageView.delegateShape = self
        
        contentView.addSubview(shapedImageView)
        contentView.addSubview(imageDescriptionButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(brandLabel)
        contentView.addSubview(descritptionLabel)
        contentView.addSubview(cartButton)
        contentView.addSubview(backButton)
        
    }
}

// MARK: - Bind ViewModel
private extension ProductDetailsViewController {
    private func bindViewModel() {
        viewModel.image.bind {
            [weak self] in
            self?.shapedImageView.imageView?.image = $0
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
            self?.descritptionLabel.text = $0
        }
    }
}

// MARK: - Layout
private extension ProductDetailsViewController {
    func layout() {
        layout(
            scrollView: scrollView,
            contentView: contentView,
            shapedImageView: shapedImageView,
            titleLabel: titleLabel,
            brandLabel: brandLabel,
            descriptionLabel: descritptionLabel,
            backButton: backButton,
            imageDescriptionButton: imageDescriptionButton,
            cartButton: cartButton
        )
    }
}

// MARK: - Assign styles
private extension ProductDetailsViewController {
    func styleViews() {
        style(scrollView: scrollView)
        style(shapedImageView: shapedImageView)
        style(titleLabel: titleLabel)
        style(descritptionLabel: descritptionLabel)
        style(cartButton: cartButton)
        style(backButton: backButton)
        style(imageDescriptionButton: imageDescriptionButton)
    }
}
