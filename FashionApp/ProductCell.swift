//
//  ProductCell.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 04.03.2022.
//

import UIKit

class ProductCell: UICollectionViewCell {
    class var reuseIdentifier: String {
        "ProductCell"
    }
    
    public var isSmall = false
    
    fileprivate var nameLabelView: UILabel!
    fileprivate var brandLabelView: UILabel!
    fileprivate var priceLabelView: UILabel!
    fileprivate var imageView: UIImageView!
    
    fileprivate var imageViewLayerDelegate: ImageViewLayerDelegate!
    
    var product: Product! {
        didSet {
            nameLabelView.text = product.name
            brandLabelView.text = "From \(product.brand)"
            priceLabelView.text = "$\(product.price)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

extension ProductCell {
    func configure() {
        
        imageView = UIImageView(image: UIImage(named: "ImageTestHoodie"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        
        nameLabelView = UILabel()
        nameLabelView.text = "Name"
        nameLabelView.translatesAutoresizingMaskIntoConstraints = false
        nameLabelView.textAlignment = .left
        nameLabelView.font = .preferredFont(forTextStyle: .headline)
        
        brandLabelView = UILabel()
        brandLabelView.text = "Brand"
        brandLabelView.translatesAutoresizingMaskIntoConstraints = false
        brandLabelView.textColor = UIColor(named: "ColorBrandLabel")
        brandLabelView.textAlignment = .left
        brandLabelView.font = .preferredFont(forTextStyle: .headline)
        
        priceLabelView = UILabel()
        priceLabelView.text = "$0"
        priceLabelView.translatesAutoresizingMaskIntoConstraints = false
        priceLabelView.textAlignment = .left
        priceLabelView.font = .preferredFont(forTextStyle: .title3)
        
        let inset = CGFloat(0)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabelView)
        contentView.addSubview(brandLabelView)
        contentView.addSubview(priceLabelView)
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameLabelView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: inset),
            nameLabelView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -inset),
            
            nameLabelView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
            brandLabelView.topAnchor.constraint(equalTo: nameLabelView.bottomAnchor, constant: 2),
            brandLabelView.trailingAnchor.constraint(equalTo: nameLabelView.trailingAnchor),
            brandLabelView.leadingAnchor.constraint(equalTo: nameLabelView.leadingAnchor),
            
            priceLabelView.topAnchor.constraint(equalTo: brandLabelView.bottomAnchor, constant: 10),
            priceLabelView.leadingAnchor.constraint(equalTo: brandLabelView.leadingAnchor),
            priceLabelView.trailingAnchor.constraint(equalTo: nameLabelView.trailingAnchor),
            
            priceLabelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
        
        imageView.layer.cornerRadius = 8
    }
}

class ProductCellRounded: ProductCell {
    override class var reuseIdentifier: String {
        "ProductCellRounded"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureImageView()
    }
    
    private func configureImageView() {
        imageViewLayerDelegate = ImageViewLayerDelegate()
        imageView.layer.mask = CAShapeLayer()
        imageView.layer.delegate = imageViewLayerDelegate
    }
}

class ImageViewLayerDelegate: NSObject, CALayerDelegate {
    func layoutSublayers(of layer: CALayer) {
        
        let bounds = layer.bounds
        let maskLayer = layer.mask as! CAShapeLayer
        
        maskLayer.bounds = layer.bounds
        maskLayer.frame = layer.frame
        
        let path = CGMutablePath()
        
        path.addEllipse(in: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width))
        path.addRect(CGRect(x: 0, y: bounds.width / 2, width: bounds.width, height: bounds.height - bounds.width / 2))
        maskLayer.path = path
        maskLayer.fillColor = UIColor.yellow.cgColor
    }
}
