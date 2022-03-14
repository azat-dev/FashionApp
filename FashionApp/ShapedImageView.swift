//
//  ShapedImageView.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 14.03.2022.
//

import UIKit

class ShapedImageView: UIView {
    typealias ShapePathCallback = (UIView) -> CGPath
    
    var imageView: UIImageView!
    var path: ShapePathCallback? {
        didSet {
            if path != nil {
                maskLayer = CAShapeLayer()
            } else {
                maskLayer = nil
            }
        }
    }
    
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
        if
            let path = path,
            let maskLayer = maskLayer
        {
            let shapePath = path(self)
            
            maskLayer.fillColor = UIColor.yellow.cgColor
            maskLayer.path = shapePath
            maskLayer.frame = self.frame
            maskLayer.bounds = bounds
            
            
            applyShadow(view: self, path: shapePath)
            layer.shadowPath = shapePath
            imageView.layer.mask = maskLayer
            
        } else {
            imageView.mask = nil
            layer.shadowPath = nil
        }
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
