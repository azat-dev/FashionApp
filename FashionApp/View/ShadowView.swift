//
//  test.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 14.03.2022.
//

import Foundation
import UIKit


protocol ShapeDelegate: AnyObject {
    func shape(view: UIView) -> CGPath?
}

class ShadowView: UIView {
    struct ShadowParams {
        var color: CGColor?
        var opacity: Float
        var radius: CGFloat
        var offset: CGSize
    }
    
    private var shadowLayers: [CALayer] = []
    var shadows: [ShadowParams] = [] {
        didSet {
            updateShadows()
        }
    }
    
    weak var delegateShape: ShapeDelegate? {
        didSet {
            updateShadows()
        }
    }
    
    private func updateLayer(layer: CALayer, params: ShadowParams, path: CGPath?) {
        layer.bounds = bounds
        layer.frame = frame
        
        layer.shadowRadius = params.radius
        layer.shadowColor = params.color
        layer.shadowOffset = params.offset
        layer.shadowPath = path
        layer.shadowOpacity = params.opacity
    }
    
    private func updateShadows() {
        let path = delegateShape?.shape(view: self) ?? CGPath(rect: bounds, transform: nil)
        
        clipsToBounds = false
        
        for index in 0..<shadows.count {
            let shadowParams = shadows[index]
            
            if index == 0 {
                updateLayer(layer: layer, params: shadowParams, path: path)
                continue
            }

            let sublayerIndex = index - 1

            if sublayerIndex <= shadowLayers.count {
                let newLayer = CALayer()
                shadowLayers.append(newLayer)

                if let lastLayer = layer.sublayers?.last {
                    self.layer.insertSublayer(newLayer, below: lastLayer)
                } else {
                    self.layer.addSublayer(newLayer)
                }
            }

            let shadowLayer = shadowLayers[sublayerIndex]
            updateLayer(layer: shadowLayer, params: shadowParams, path: path)
        }
        
        while (shadows.count - 1) > shadowLayers.count {
            let sublayer = shadowLayers.popLast()
            sublayer?.removeFromSuperlayer()
        }

        if shadows.isEmpty {
            layer.shadowPath = path
            layer.shadowColor = nil
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        updateShadows()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadows()
    }
}
