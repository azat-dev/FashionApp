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
    fileprivate var shapedImageView: ShapedImageView!
    
    var singleTap: UIGestureRecognizer!
    
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
        
        shapedImageView = ShapedImageView()
        shapedImageView.imageView.image = UIImage(named: "ImageTestHoodie")
        shapedImageView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        shapedImageView.path = {
            containerView in
            CGPath(
                roundedRect: containerView.frame,
                cornerWidth: 8,
                cornerHeight: 8,
                transform: nil
            )
        }
    }
    
    @objc
    func tapImageView() {
        print("TAP")
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
        shapedImageView.path = Self.path
        shapedImageView.imageView.clipsToBounds = true
    }
    
    private static func path(_ containerView: UIView) -> CGPath {
        
        let cornerRadius: CGFloat = 10

        let bounds = containerView.bounds

        let width = bounds.width
        let height = containerView.bounds.maxY
        let radius = width / 2

        let origin = containerView.frame.origin
        
        let path = CGMutablePath()

        path.addArc(
            center: CGPoint(x: origin.x + radius, y: origin.y + radius),
            radius: radius,
            startAngle: 0,
            endAngle: CGFloat(180).radians,
            clockwise: true
        )

        path.addLine(to: CGPoint(
            x: origin.x,
            y: origin.y + height - cornerRadius)
        )

        path.addArc(
            center: CGPoint(
                x: origin.x + cornerRadius,
                y: origin.y + height - cornerRadius
            ),
            radius: cornerRadius,
            startAngle: CGFloat(180).radians,
            endAngle: CGFloat(90).radians,
            clockwise: true
        )

        path.addLine(to: CGPoint(
            x: origin.x + width - cornerRadius,
            y: origin.y + height
        ))

        path.addArc(
            center: CGPoint(
                x: origin.x + width - cornerRadius,
                y: origin.y + height - cornerRadius
            ),
            radius: cornerRadius,
            startAngle: CGFloat(90).radians,
            endAngle: CGFloat(0).radians,
            clockwise: true
        )

        path.closeSubpath()
        
        return path
    }
}


extension CGFloat {
    var radians: CGFloat {
        self * .pi / 180.0
    }
}
