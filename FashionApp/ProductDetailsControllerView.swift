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
    private var backButton: UIButton!
    private var imageDescriptionButton: UIButton!
    
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
    

        
        if #available(iOS 15, *) {
            var imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
            let image = UIImage(systemName: "viewfinder", withConfiguration: imageConfig)

            
            var imageDescriptionButtonConfig = UIButton.Configuration.bordered()
            imageDescriptionButtonConfig.image = image
            imageDescriptionButtonConfig.baseBackgroundColor = UIColor(named: "ColorImageDescriptionButtonBackground")
            imageDescriptionButtonConfig.baseForegroundColor = UIColor(named: "ColorImageDescriptionButtonForeground")
            imageDescriptionButtonConfig.cornerStyle = .capsule
            imageDescriptionButtonConfig.contentInsets = NSDirectionalEdgeInsets(all: 16)
            imageDescriptionButtonConfig.background.strokeColor = UIColor(named: "ColorImageDescriptionButtonBorder")
            imageDescriptionButtonConfig.background.strokeWidth = 1
            
            imageDescriptionButton = UIButton(type: .system)
            imageDescriptionButton.translatesAutoresizingMaskIntoConstraints = false
            imageDescriptionButton.configuration = imageDescriptionButtonConfig
        }
        
        
        let cartButtonCornerRadius: CGFloat = 12
        let cartButtonImage = UIImage(systemName: "cart")
        let cartButtonBackgroundColor = UIColor(named: "ColorProductCellBackground")
        let cartButtonFont = UIFont.preferredFont(name: "RedHatDisplay-Medium", forTextStyle: .body)
        let cartButtonForegroundColor = UIColor.black

        
        let cartButtonImageInset: CGFloat = 10
        let cartButtonContentInsets = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        
        if #available(iOS 15, *) {
            var cartButtonConfig = UIButton.Configuration.filled();
            
            var attString = AttributedString.init("Add to cart")
            attString.font = cartButtonFont
            
            cartButtonConfig.attributedTitle = attString
            cartButtonConfig.baseForegroundColor = UIColor.black
            cartButtonConfig.baseBackgroundColor = cartButtonBackgroundColor
            cartButtonConfig.cornerStyle = .fixed
            cartButtonConfig.background.cornerRadius = cartButtonCornerRadius
            
            cartButtonConfig.contentInsets.top = cartButtonContentInsets.top
            cartButtonConfig.contentInsets.bottom = cartButtonContentInsets.bottom
            cartButtonConfig.contentInsets.leading = cartButtonContentInsets.left
            cartButtonConfig.contentInsets.trailing = cartButtonContentInsets.right
            
            cartButtonConfig.image = cartButtonImage
            cartButtonConfig.imagePadding = cartButtonImageInset
            
            cartButton = UIButton(configuration: cartButtonConfig, primaryAction: nil)
            cartButton.configuration = cartButtonConfig
            
        } else {
            
            cartButton = UIButton(type: .system)
            cartButton.tintColor = cartButtonForegroundColor
            cartButton.backgroundColor = cartButtonBackgroundColor
            cartButton.setTitle("Add to cart", for: .normal)
            cartButton.setImage(cartButtonImage, for: .normal)
            cartButton.contentEdgeInsets = cartButtonContentInsets
            cartButton.titleLabel?.font = cartButtonFont
            cartButton.layer.cornerRadius = cartButtonCornerRadius
        }
        
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        
       
        let backButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        let backButtonImage = UIImage(systemName: "arrow.left")?.withConfiguration(backButtonImageConfig)
        
        if #available(iOS 15, *) {
            
            var backButtonConfig = UIButton.Configuration.plain()
            backButtonConfig.baseForegroundColor = .black
            backButtonConfig.image = backButtonImage
            
            backButton = UIButton(configuration: backButtonConfig, primaryAction: nil)
        } else {
            backButton = UIButton(type: .system)
            backButton.setImage(backButtonImage, for: .normal)
            backButton.tintColor = .black
        }
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(Self.onGoBack), for: .touchUpInside)


        contentView.addSubview(shapedImageView)
        contentView.addSubview(imageDescriptionButton)
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
            
            imageDescriptionButton.bottomAnchor.constraint(equalTo: shapedImageView.bottomAnchor, constant: -20),
            imageDescriptionButton.trailingAnchor.constraint(equalTo: shapedImageView.trailingAnchor, constant: -18),
            
            backButton.topAnchor.constraint(equalTo: shapedImageView.topAnchor, constant: 15),
            backButton.leadingAnchor.constraint(equalTo: shapedImageView.leadingAnchor, constant: 10),

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
    
    @objc
    private func onGoBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension ProductDetailsViewController: ShapeDelegate {
    func shape(view containerView: UIView) -> CGPath? {
        return CGPath(
            roundedRect: containerView.bounds,
            cornerWidth: 20,
            cornerHeight: 20,
            transform: nil
        )
    }
}
