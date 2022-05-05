//
//  ShapedView.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 14.03.2022.
//

import UIKit

class ShapedView: UIView {
    
    var shape: ShapeCallback? {
        didSet {
            updateMask()
        }
    }
    
    private var currentPath: CGPath!
    private var maskLayer: CAShapeLayer?
    
    private func updateMask() {
        guard
            let shapePath = shape?(self)
        else {
            layer.mask = nil
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
        
        layer.mask = maskLayer
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateMask()
    }
}
