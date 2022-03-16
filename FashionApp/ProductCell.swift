//
//  ProductCell.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 04.03.2022.
//

import UIKit

class ProductCell: UICollectionViewCell, ShapeDelegate {
    class var reuseIdentifier: String {
        "ProductCell"
    }
    
    public var isSmall = false
    
    fileprivate var nameLabelView: UILabel!
    fileprivate var brandLabelView: UILabel!
    fileprivate var priceLabelView: UILabel!
    fileprivate var shapedImageView: ShapedImageView!
    
    var singleTap: UIGestureRecognizer!
    
    var product: Product! {
        didSet {
            nameLabelView.text = product.name
            brandLabelView.text = "From \(product.brand)"
            priceLabelView.text = "€\(product.price)"
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
    
    func shape(view containerView: UIView) -> CGPath? {
        CGPath(
            roundedRect: containerView.frame,
            cornerWidth: 8,
            cornerHeight: 8,
            transform: nil
        )
    }
}

extension ProductCell {
    func configure() {
        
        shapedImageView = ShapedImageView()
        shapedImageView.imageView.image = UIImage(named: "ImageTestHoodie")
        shapedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let shadowColor = UIColor(red: 0.094, green: 0.153, blue: 0.294, alpha: 1).cgColor
        
        shapedImageView.shadows = [
            .init(
                color: shadowColor,
                opacity: 0.08,
                radius: 24,
                offset: CGSize(width: 0, height: 8)
            ),
            .init(
                color: shadowColor,
                opacity: 0.12,
                radius: 12,
                offset: CGSize(width: 0, height: 6)
            ),
        ]
        
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
        
        contentView.addSubview(shapedImageView)
        contentView.addSubview(nameLabelView)
        contentView.addSubview(brandLabelView)
        contentView.addSubview(priceLabelView)
        
        
        NSLayoutConstraint.activate([
            shapedImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            shapedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shapedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameLabelView.leadingAnchor.constraint(equalTo: shapedImageView.leadingAnchor, constant: inset),
            nameLabelView.trailingAnchor.constraint(equalTo: shapedImageView.trailingAnchor, constant: -inset),
            
            nameLabelView.topAnchor.constraint(equalTo: shapedImageView.bottomAnchor, constant: 10),
            
            brandLabelView.topAnchor.constraint(equalTo: nameLabelView.bottomAnchor, constant: 2),
            brandLabelView.trailingAnchor.constraint(equalTo: nameLabelView.trailingAnchor),
            brandLabelView.leadingAnchor.constraint(equalTo: nameLabelView.leadingAnchor),
            
            priceLabelView.topAnchor.constraint(equalTo: brandLabelView.bottomAnchor, constant: 10),
            priceLabelView.leadingAnchor.constraint(equalTo: brandLabelView.leadingAnchor),
            priceLabelView.trailingAnchor.constraint(equalTo: nameLabelView.trailingAnchor),
            
            priceLabelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
        
        contentView.isUserInteractionEnabled = true
        singleTap = UIGestureRecognizer(target: self, action: #selector(tapImageView))
        contentView.addGestureRecognizer(singleTap)

        shapedImageView.delegateShape = self
    }
    
    @objc
    func tapImageView() {
        print("TAP")
    }
}
