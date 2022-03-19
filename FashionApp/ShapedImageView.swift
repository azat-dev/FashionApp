//
//  ShapedImageView.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 14.03.2022.
//

import UIKit

class ShapedImageView: ShadowView {
    
    var imageView: UIImageView!
    override var delegateShape: ShapeDelegate? {
        didSet {
            updateMask()
        }
    }
    
    private var currentPath: CGPath!
    private var maskLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func updateMask() {
        guard
            let shapePath = delegateShape?.shape(view: self)
        else {
            imageView.layer.mask = nil
            maskLayer = nil
            return
        }
        
        if maskLayer == nil {
            maskLayer = CAShapeLayer()
            maskLayer?.anchorPoint = .zero
            maskLayer?.position = .zero
        }
        
        guard let maskLayer = maskLayer else {
            return
        }
        
        maskLayer.fillColor = UIColor.yellow.cgColor
        maskLayer.path = shapePath
        maskLayer.bounds = bounds
        
        print("MAsk \(maskLayer.bounds) \(maskLayer.frame) \(shapePath.boundingBox)")
        
        imageView.layer.mask = maskLayer
        imageView.clipsToBounds = true
    }
    
    private func setupViews() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        updateMask()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateMask()
    }
}
