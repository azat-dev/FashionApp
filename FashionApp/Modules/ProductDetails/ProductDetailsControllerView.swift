//
//  ProductDetailsViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 16.03.2022.
//

import Foundation
import UIKit

class ProductDetailsViewController<Layout: ProductDetailsViewLayoutable, Styles: ProductDetailsViewStylable>: UIViewController {
    
    private var backButton = UIButton(type: .system)
    private var scrollView = UIScrollView()
    private var shapedImageView = ShapedImageView()
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
        setupViews()
        style()
        layout()
        bindViewModel()
    }
    
    @objc
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("Deinit details")
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
        
        contentView.addSubview(shapedImageView)
        contentView.addSubview(imageDescriptionButton)
        view.addSubview(titleLabel)
        contentView.addSubview(brandLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(cartButton)
        view.addSubview(backButton)
        
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
            self?.descriptionLabel.text = $0
        }
    }
}

// MARK: - Layout
protocol ProductDetailsViewLayoutable {
    static func apply(
        view: UIView,
        scrollView: UIScrollView,
        contentView: UIView,
        shapedImageView: ShapedImageView,
        titleLabel: UILabel,
        brandLabel: UILabel,
        descriptionLabel: UILabel,
        backButton: UIButton,
        imageDescriptionButton: UIButton,
        cartButton: UIButton
    )
}

private extension ProductDetailsViewController {
    func layout() {
        Layout.apply(
            view: view,
            scrollView: scrollView,
            contentView: contentView,
            shapedImageView: shapedImageView,
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
        Styles.apply(shapedImageView: shapedImageView)
        Styles.apply(titleLabel: titleLabel)
        Styles.apply(descriptionLabel: descriptionLabel)
        Styles.apply(cartButton: cartButton)
        Styles.apply(backButton: backButton)
        Styles.apply(imageDescriptionButton: imageDescriptionButton)
    }
}
