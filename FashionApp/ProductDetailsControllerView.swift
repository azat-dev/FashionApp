//
//  ProductDetailsViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 16.03.2022.
//

import Foundation
import UIKit

class ProductDetailsViewController: UIViewController {
    private var scrollView: UIScrollView!
    private var shapedImageView: ShapedImageView!
    private var titleLabel: UILabel!
    private var brandLabel: UILabel!
    private var descritptionLabel: UILabel!
    private var cartButton: UIButton!
    
    var product: Product! {
        didSet {
            updateViewsFromProduct()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.systemBackground
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.frame = view.frame
        scrollView.backgroundColor = UIColor.systemBackground
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        shapedImageView = ShapedImageView()
        shapedImageView.translatesAutoresizingMaskIntoConstraints = false
        shapedImageView.imageView.image = UIImage(named: "ImageTestHoodie")
        shapedImageView.imageView.backgroundColor = UIColor(named: "ColorProductCellBackground")
        shapedImageView.delegateShape = self
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Title"
        titleLabel.font = UIFont.preferredFont(name: "RedHatDisplay-Medium", forTextStyle: .largeTitle)
        titleLabel.textAlignment = .left
        
        brandLabel = UILabel()
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.text = "Brand"
        brandLabel.font = UIFont.preferredFont(name: "RedHatDisplay-Medium", forTextStyle: .body)
        brandLabel.textAlignment = .left
        brandLabel.textColor = UIColor(named: "ColorBrandLabel")
        
        descritptionLabel = UILabel()
        descritptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descritptionLabel.text = "Description"
        descritptionLabel.font = UIFont.preferredFont(name: "RedHatDisplay-Medium", forTextStyle: .subheadline)
        descritptionLabel.textAlignment = .justified
        descritptionLabel.textColor = UIColor(named: "ColorProductDescription")
        descritptionLabel.lineBreakMode = .byWordWrapping
        descritptionLabel.numberOfLines = 0
        
        cartButton = UIButton()
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        cartButton.titleLabel?.text = "Add to cart"
        
        contentView.addSubview(shapedImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(brandLabel)
        contentView.addSubview(descritptionLabel)
        contentView.addSubview(cartButton)
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            shapedImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0),
            shapedImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0),
            shapedImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0),
            shapedImageView.heightAnchor.constraint(equalTo: shapedImageView.widthAnchor, multiplier: 1.4, constant: 0),

            titleLabel.topAnchor.constraint(equalTo: shapedImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: shapedImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: shapedImageView.trailingAnchor),
//            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            brandLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            brandLabel.leadingAnchor.constraint(equalTo: shapedImageView.leadingAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: shapedImageView.trailingAnchor),

            descritptionLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 10),
            descritptionLabel.leadingAnchor.constraint(equalTo: shapedImageView.leadingAnchor),
            descritptionLabel.trailingAnchor.constraint(equalTo: shapedImageView.trailingAnchor),
            descritptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            cartButton.widthAnchor.constraint(equalTo: shapedImageView.widthAnchor),
            cartButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cartButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        
        updateViewsFromProduct()
    }
    
    private func updateViewsFromProduct() {
        guard let titleLabel = titleLabel else {
            return
        }
        
        titleLabel.text = product.name
        brandLabel.text = "FROM \(product.brand)"
        descritptionLabel.text = product.description
    }
}

extension ProductDetailsViewController: ShapeDelegate {
    func shape(view containerView: UIView) -> CGPath? {
        return CGPath(
            roundedRect: containerView.bounds,
            cornerWidth: 10,
            cornerHeight: 10,
            transform: nil
        )
    }
}
