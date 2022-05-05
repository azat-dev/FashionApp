//
//  PriceTagStyles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 11.04.22.
//

import Foundation
import UIKit

protocol PriceTagStylable {
    static func apply(button: UIButton)
    static func apply(labelShape: ShapedView)
    static func apply(nameLabel: UILabel)
    static func apply(priceLabel: UILabel)
}

class PriceTagStyles: PriceTagStylable {
    
    class func apply(button: UIButton) {
        guard #available(iOS 15.0, *) else {
            return
        }
        
        var configuration = UIButton.Configuration.bordered()
        
        configuration.baseBackgroundColor = UIColor(named: "ColorPriceTagButtonBackground")
        configuration.background.strokeColor = UIColor(named: "ColorPriceTagButtonBorder")
        configuration.background.strokeWidth = 6
        configuration.cornerStyle = .capsule
        configuration.contentInsets = .init(all: 20)
        
        
        button.configuration = configuration
//        button.bounds = .init(x: 0, y: 0, width: 50, height: 50)
    }
    
    class func apply(labelShape: ShapedView) {
        labelShape.backgroundColor = UIColor(named: "ColorPriceTagLabelBackground")?.withAlphaComponent(0.4)
        
        let cornerRadius: CGFloat = 10
        let smallCornerRadius: CGFloat = 5
        
        let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurEffect.translatesAutoresizingMaskIntoConstraints = true
        blurEffect.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        labelShape.insertSubview(blurEffect, at: 0)
        
        labelShape.shape = { view in

            let path = CGMutablePath()

            guard
                view.subviews.count >= 2
            else {
                return path
            }

            let nameLabel = view.subviews[1] as! UILabel
            let priceLabel = view.subviews[2]
            
            if nameLabel.bounds == .zero || priceLabel.bounds == .zero {
                return path
            }
            
            let bounds = view.bounds
            let priceBounds = priceLabel.convert(priceLabel.bounds, to: view)
            let origin = bounds.origin
            
            let priceInsets = priceLabel.layoutMargins
            let priceBoundsWithInsets = CGRect(
                x: priceBounds.minX + priceInsets.left,
                y: priceBounds.minY + priceInsets.top,
                width: priceBounds.width - priceInsets.left - priceInsets.right,
                height: priceBounds.height - priceInsets.top - priceInsets.bottom
            )
            
            let bottomEdgeY = priceBoundsWithInsets.midY
            
            let points: [CGPoint] = [
                .init(
                    x: origin.x,
                    y: origin.y
                ),
                .init(
                    x: bounds.maxX,
                    y: bounds.minY
                ),
                .init(
                    x: bounds.maxX,
                    y: bottomEdgeY
                ),
                .init(
                    x: priceBoundsWithInsets.maxX,
                    y: bottomEdgeY
                ),
                .init(
                    x: priceBoundsWithInsets.maxX,
                    y: priceBoundsWithInsets.maxY
                ),
                .init(
                    x: priceBoundsWithInsets.minX,
                    y: priceBoundsWithInsets.maxY
                ),
                .init(
                    x: priceBoundsWithInsets.minX,
                    y: bottomEdgeY
                ),
                .init(
                    x: origin.x,
                    y: bottomEdgeY
                ),
            ]
            
            path.addArc(
                center: CGPoint(
                    x: points[0].x + cornerRadius,
                    y: points[0].y + cornerRadius
                ),
                radius: cornerRadius,
                startAngle: CGFloat(180).radians,
                endAngle: CGFloat(270).radians,
                clockwise: false
            )
            
            path.addLine(to: CGPoint(
                x: points[1].x - cornerRadius,
                y: points[1].y
            ))
            
            path.addArc(
                center: CGPoint(
                    x: points[1].x - cornerRadius,
                    y: points[1].y + cornerRadius
                ),
                radius: cornerRadius,
                startAngle: CGFloat(270).radians,
                endAngle: CGFloat(0).radians,
                clockwise: false
            )

            
            path.addLine(to: CGPoint(
                x: points[2].x,
                y: points[2].y - cornerRadius
            ))

            path.addArc(
                center: CGPoint(
                    x: points[2].x - cornerRadius,
                    y: points[2].y - cornerRadius
                ),
                radius: cornerRadius,
                startAngle: CGFloat(0).radians,
                endAngle: CGFloat(90).radians,
                clockwise: false
            )

            path.addLine(to: CGPoint(
                x: points[3].x - smallCornerRadius,
                y: points[3].y
            ))

            path.addArc(
                center: CGPoint(
                    x: points[3].x + smallCornerRadius,
                    y: points[3].y + smallCornerRadius
                ),
                radius: smallCornerRadius,
                startAngle: CGFloat(270).radians,
                endAngle: CGFloat(180).radians,
                clockwise: true
            )
            
            path.addLine(to: CGPoint(
                x: points[4].x,
                y: points[4].y
            ))
            
            path.addArc(
                center: CGPoint(
                    x: points[4].x - smallCornerRadius,
                    y: points[4].y - smallCornerRadius
                ),
                radius: smallCornerRadius,
                startAngle: CGFloat(0).radians,
                endAngle: CGFloat(90).radians,
                clockwise: false
            )
            
            path.addLine(to: CGPoint(
                x: points[5].x - smallCornerRadius,
                y: points[5].y
            ))
            
            path.addArc(
                center: CGPoint(
                    x: points[5].x + smallCornerRadius,
                    y: points[5].y - smallCornerRadius
                ),
                radius: smallCornerRadius,
                startAngle: CGFloat(90).radians,
                endAngle: CGFloat(180).radians,
                clockwise: false
            )
            
            path.addLine(to: CGPoint(
                x: points[6].x,
                y: points[6].y + smallCornerRadius
            ))
            
            path.addArc(
                center: CGPoint(
                    x: points[6].x - smallCornerRadius,
                    y: points[6].y + smallCornerRadius
                ),
                radius: smallCornerRadius,
                startAngle: CGFloat(0).radians,
                endAngle: CGFloat(270).radians,
                clockwise: true
            )
            
            path.addLine(to: CGPoint(
                x: points[7].x + cornerRadius,
                y: points[7].y
            ))
            
            path.addArc(
                center: CGPoint(
                    x: points[7].x + cornerRadius,
                    y: points[7].y - cornerRadius
                ),
                radius: cornerRadius,
                startAngle: CGFloat(90).radians,
                endAngle: CGFloat(180).radians,
                clockwise: false
            )

            path.closeSubpath()
            return path
        }
    }
    
    class func apply(nameLabel: UILabel) {
        nameLabel.textAlignment = .center
        nameLabel.layer.cornerRadius = 10
        nameLabel.textColor = .white
        nameLabel.font = Fonts.RedHatDisplay.medium.preferred(with: .subheadline)
    }
    
    class func apply(priceLabel: UILabel) {
        priceLabel.numberOfLines = 0
        priceLabel.textAlignment = .center
        priceLabel.layer.cornerRadius = 10
        priceLabel.textColor = .white
        priceLabel.font = Fonts.RedHatDisplay.medium.preferred(with: .caption1)
    }
}
