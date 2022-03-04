//
//  ProductCell.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 04.03.2022.
//

import UIKit

class ProductCell: UICollectionViewCell {
    static let reuseIdentifier = "ProductCell"
    
    private var nameLabelView: UILabel!
    private var brandLabelView: UILabel!
    private var priceLabelView: UILabel!
    private var imageView: UIImageView!
    
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
        imageView.layer.cornerRadius = 10
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
    }
}
