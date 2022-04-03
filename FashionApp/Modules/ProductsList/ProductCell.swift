//
//  ProductCell.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 04.03.2022.
//

import UIKit

protocol ProductCellWithViewModel: AnyObject {
    var viewModel: ProductCellViewModel? { get set }
}

class ProductCell<Layout: ProductCellLayoutable, Styles: ProductCellStylable>: UICollectionViewCell, ProductCellWithViewModel {

    private var nameLabel: UILabel = UILabel()
    private var brandLabel: UILabel = UILabel()
    private var priceLabel: UILabel = UILabel()
    private var shapedImage: ShapedImageView = ShapedImageView()

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
protocol ProductCellStylable {
    static func apply(nameLabel: UILabel)
    static func apply(brandLabel: UILabel)
    static func apply(priceLabel: UILabel)
    static func apply(shapedImageView: ShapedImageView)
}

private extension ProductCell {
    func style() {
        Styles.apply(shapedImageView: shapedImage)
        Styles.apply(nameLabel: nameLabel)
        Styles.apply(brandLabel: brandLabel)
        Styles.apply(priceLabel: priceLabel)
    }
}

// MARK: - Layout
protocol ProductCellLayoutable {
    static func apply (
        contentView: UIView,
        shapedImage: ShapedImageView,
        nameLabel: UILabel,
        brandLabel: UILabel,
        priceLabel: UILabel
    )
}

private extension ProductCell {
    func layout() {
        Layout.apply(
            contentView: contentView,
            shapedImage: shapedImage,
            nameLabel: nameLabel,
            brandLabel: brandLabel,
            priceLabel: priceLabel
        )
    }
}
