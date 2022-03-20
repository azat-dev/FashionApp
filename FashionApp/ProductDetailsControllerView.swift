//
//  ProductDetailsViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 16.03.2022.
//

import Foundation
import UIKit

class GrayButton: UIButton {
    override var backgroundColor: UIColor? {
        get {
            UIColor.black
        }
        
        set {
        }
    }
    
    
}

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
        navigationController?.isNavigationBarHidden = true
        
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
        descritptionLabel.textAlignment = .left
        descritptionLabel.textColor = UIColor(named: "ColorProductDescription")
        descritptionLabel.lineBreakMode = .byWordWrapping
        descritptionLabel.numberOfLines = 0
        

        
        cartButton = UIButton(type: .system)
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let cartButtonCornerRadius: CGFloat = 10
        let cartButtonImage = UIImage(systemName: "cart")
        let cartButtonBackgroundColor = UIColor(named: "ColorProductCellBackground")
        let cartButtonFont = UIFont.preferredFont(name: "RedHatDisplay-Medium", forTextStyle: .body)
        let cartButtonForegroundColor = UIColor.black

        
        let cartButtonImageInset: CGFloat = 10
        let cartButtonContentInsets = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        
        if #available(iOS 15, *) {
            var cartButtonConfiguration = UIButton.Configuration.filled();
            
            var attString = AttributedString.init("Add to cart")
            attString.font = cartButtonFont
            
            cartButtonConfiguration.attributedTitle = attString
            cartButtonConfiguration.baseForegroundColor = UIColor.black
            cartButtonConfiguration.baseBackgroundColor = cartButtonBackgroundColor
            cartButtonConfiguration.cornerStyle = .fixed
            cartButtonConfiguration.background.cornerRadius = cartButtonCornerRadius
            
            cartButtonConfiguration.contentInsets.top = cartButtonContentInsets.top
            cartButtonConfiguration.contentInsets.bottom = cartButtonContentInsets.bottom
            cartButtonConfiguration.contentInsets.leading = cartButtonContentInsets.left
            cartButtonConfiguration.contentInsets.trailing = cartButtonContentInsets.right
            
            cartButtonConfiguration.image = cartButtonImage
            cartButtonConfiguration.imagePadding = cartButtonImageInset
            
            cartButton.configuration = cartButtonConfiguration
            
        } else {
            
            cartButton.tintColor = cartButtonForegroundColor
            cartButton.backgroundColor = cartButtonBackgroundColor
            cartButton.setTitle("Add to cart", for: .normal)
            cartButton.setImage(cartButtonImage, for: .normal)
            cartButton.contentEdgeInsets = cartButtonContentInsets
            cartButton.titleLabel?.font = cartButtonFont
            cartButton.layer.cornerRadius = cartButtonCornerRadius
//            cartButton.imageEdgeInsets = UIEdgeInsets(
//                top: cartButtonImageInset,
//                left: cartButtonImageInset,
//                bottom: cartButtonImageInset,
//                right: cartButtonImageInset
//            )
        }
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)

        
        contentView.addSubview(shapedImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(brandLabel)
        contentView.addSubview(descritptionLabel)
        contentView.addSubview(cartButton)
        contentView.addSubview(backButton)
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.98),
            
            shapedImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            shapedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            shapedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            shapedImageView.heightAnchor.constraint(equalTo: shapedImageView.widthAnchor, multiplier: 1.37, constant: 0),

            titleLabel.topAnchor.constraint(equalTo: shapedImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            brandLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            brandLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            descritptionLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 10),
            descritptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descritptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descritptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            cartButton.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            cartButton.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
            
            cartButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cartButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            backButton.leftAnchor.constraint(equalTo: shapedImageView.leftAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: shapedImageView.topAnchor, constant: 10)
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
