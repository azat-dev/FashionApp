//
//  ProductDetailsFullScreenImage.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 07.04.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

class ProductDetailsFullScreenImage<Styles: ProductDetailsFullScreenImageStylable, Layout: ProductDetailsFullScreenImageLayout>: UIViewController {
    
    private var imageView = UIImageViewAligned()
    private var backButton = UIButton()
    private var buyButton = UIButton()
    
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
        style()
        layout()
    }
    
    @objc
    private func goBack() {
        guard let navigationController = navigationController else {
            dismiss(animated: true)
            return
        }
        
        
        navigationController.popViewController(animated: true)
    }
}

// MARK: - Setup views
extension ProductDetailsFullScreenImage {
    private func setupViews() {
        
        backButton.addTarget(self, action: #selector(Self.goBack), for: .touchUpInside)
        
        buyButton.addTarget(self, action: #selector(Self.goBack), for: .touchUpInside)
        
        view.addSubview(imageView)
        view.addSubview(buyButton)
        view.addSubview(backButton)
    }
}


// MARK: - Bind ViewModel
extension ProductDetailsFullScreenImage {
    private func bindViewModel() {
        viewModel?.image.bind { [weak self] newImage in
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
