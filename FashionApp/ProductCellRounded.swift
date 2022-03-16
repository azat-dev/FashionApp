//
//  ProductCellRounded.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 16.03.2022.
//

import Foundation
import UIKit

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
//        shapedImageView.imageView.clipsToBounds = true
    }

    override func shape(view containerView: UIView) -> CGPath? {
        
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
