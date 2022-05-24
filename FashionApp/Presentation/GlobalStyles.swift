//
//  GlobalStyles.swift
//  FashionApp
//
//

import Foundation
import UIKit

class GlobalStyles {
    private static let loadingLayerIdentifier = "loadingAnimation"
    
    private static func getLoadingAnimationLayer(view: UIView) -> CALayer? {
        return (view.layer.sublayers ?? []).first { sublayer in
            guard let layer = sublayer as? CAGradientLayer, let name = layer.name else {
                return false
            }
            
            return name == loadingLayerIdentifier
        }
    }
    
    private static func addLoadingAnimation(view: UILabel) {
        guard getLoadingAnimationLayer(view: view) == nil else {
            return
        }
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.name = loadingLayerIdentifier
        gradientLayer.bounds = view.bounds
        gradientLayer.anchorPoint = .init(x: 0, y: 0)
        gradientLayer.startPoint = .init(x: 1, y: 0)
        gradientLayer.endPoint = .init(x: 0, y: 1)
        gradientLayer.locations = [
            0.2,
            0.6,
            1
        ]
        gradientLayer.colors = [
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(0.5).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor,
        ]

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 1
        animation.fromValue = -view.bounds.width
        animation.toValue = view.bounds.width
        animation.repeatCount = Float.infinity

        gradientLayer.add(animation, forKey: "loadingAnimation")
        view.layer.addSublayer(gradientLayer)
    }
    
    static func apply(viewDisabledLoading view: UIView) {
        guard let loadingLayer = getLoadingAnimationLayer(view: view) else {
            return
        }

        loadingLayer.removeFromSuperlayer()
    }
    
    static func apply(loadingLabel: UILabel) {
        loadingLabel.textColor = .clear
        loadingLabel.backgroundColor = UIColor(named: "ColorProductCellBackground")
        loadingLabel.layer.cornerRadius = 5
        loadingLabel.clipsToBounds = true
        
        addLoadingAnimation(view: loadingLabel)
//        let animation = CABasicAnimation(keyPath: "opacity")
//
//        animation.fromValue = 0.2
//        animation.toValue = 0.9
//        animation.duration = 1
//        animation.repeatCount = .infinity
//        animation.autoreverses = true
//
//        loadingLabel.layer.add(animation, forKey: "loadingAnimation")
    }
    
}
