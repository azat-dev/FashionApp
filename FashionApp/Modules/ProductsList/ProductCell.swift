//
//  ProductCell.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 04.03.2022.
//

import UIKit

class ProductCell: UICollectionViewCell {

    private lazy var nameLabel: UILabel = UILabel()
    private lazy var brandLabel: UILabel = UILabel()
    private lazy var priceLabel: UILabel = UILabel()
    private lazy var shapedImage: ShapedImageView = ShapedImageView()

    class var reuseIdentifier: String {
        "ProductCell"
    }
    
    public var viewModel: ProductCellViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setupViews()
        layout()
        bindViewModel()
        style()
    }
}

// MARK: - Set up views
extension ProductCell {
    func setupViews() {
        contentView.addSubview(shapedImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(brandLabel)
        contentView.addSubview(priceLabel)
    }
}

// MARK: - Bind the ViewModel
private extension ProductCell {
    func bindViewModel() {
        guard let viewModel = viewModel else {
            return
        }
            
        viewModel.name.bind {
            [weak self] in
            self?.nameLabel.text = $0
        }
        
        viewModel.brand.bind {
            [weak self] in
            self?.brandLabel.text = $0
        }
        
        viewModel.price.bind {
            [weak self] in
            self?.priceLabel.text = $0
        }
        
        viewModel.image.bind {
            [weak self] in
            self?.shapedImage.imageView.image = $0
        }
    }
}

// MARK: - Assign styles
private extension ProductCell {
    func style() {
        Self.style(shapedImageView: shapedImage)
        Self.style(nameLabel: nameLabel)
        Self.style(brandLabel: brandLabel)
        Self.style(priceLabel: priceLabel)
    }
}

// MARK: - Layout
private extension ProductCell {
    func layout() {
        layout(
            shapedImage: shapedImage,
            nameLabel: nameLabel,
            brandLabel: brandLabel,
            priceLabel: priceLabel
        )
    }
}
