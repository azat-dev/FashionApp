//
//  ProductCell.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 04.03.2022.
//

import UIKit
import UIImageViewAlignedSwift

typealias ProductCellStyled = ProductCell<ProductCellLayout, ProductCellStyles>

class ProductCell<Layout: ProductCellLayoutable, Styles: ProductCellStylable>: UICollectionViewCell, ProductCellWithViewModel {

    private var nameLabel: UILabel = UILabel()
    private var brandLabel: UILabel = UILabel()
    private var priceLabel: UILabel = UILabel()
    private var imageShadow = ShadowView()
    private var asyncImageView = AsyncImageViewAligned()
    private var imageContainer = ShapedView()

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
        imageContainer.addSubview(asyncImageView)
        imageShadow.addSubview(imageContainer)

        contentView.addSubview(imageShadow)
        contentView.addSubview(nameLabel)
        contentView.addSubview(brandLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(imageContainer)
    }
}

// MARK: - Bind the ViewModel
private extension ProductCell {
    func bindViewModel() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        asyncImageView.loadImage = viewModel.loadImage
            
        viewModel.name.bind { [weak self] name, _ in
            self?.nameLabel.text = name
        }
        
        viewModel.brand.bind { [weak self] brand, _ in
            self?.brandLabel.text = brand
        }
        
        viewModel.price.bind { [weak self] price, _ in
            self?.priceLabel.text = price
        }
        
        viewModel.imageUrl.bind { [weak self] imageUrl, _ in
            self?.asyncImageView.url = imageUrl
        }
        
        viewModel.isLoading.bind { [weak self] isLoading, _ in
            guard let self = self else {
                return
            }
            
            if isLoading {
                Styles.apply(nameLabelLoading: self.nameLabel)
                Styles.apply(brandLabelLoading: self.brandLabel)
                Styles.apply(priceLabelLoading: self.priceLabel)
                return
            }
            
            Styles.apply(nameLabel: self.nameLabel)
            Styles.apply(brandLabel: self.brandLabel)
            Styles.apply(priceLabel: self.priceLabel)
        }
    }
}

// MARK: - Assign styles
private extension ProductCell {
    func style() {
        Styles.apply(imageShadow: imageShadow)
        Styles.apply(imageContainer: imageContainer)
        Styles.apply(asyncImageView: asyncImageView)
        Styles.apply(nameLabel: nameLabel)
        Styles.apply(brandLabel: brandLabel)
        Styles.apply(priceLabel: priceLabel)
    }
}

// MARK: - Layout
private extension ProductCell {
    func layout() {
        Layout.apply(
            contentView: contentView,
            imageShadow: imageShadow,
            imageContainer: imageContainer,
            asyncImageView: asyncImageView,
            nameLabel: nameLabel,
            brandLabel: brandLabel,
            priceLabel: priceLabel
        )
    }
}
