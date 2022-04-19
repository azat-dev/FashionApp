//
//  ImageViewShadowed.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 18.04.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

class ImageViewShadowed: UIView {
    var shadowView = ShadowView()
    var containerView = ShapedView()
    var imageView = UIImageViewAligned()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setupViews()
        layout()
    }
}

// MARK: - Setup Views
extension ImageViewShadowed {
    private func setupViews() {
        containerView.addSubview(imageView)
        addSubview(shadowView)
        addSubview(containerView)
    }
}

// MARK: - Layout
extension ImageViewShadowed {
    private func layout() {
        UIView.disableAutoresizingMaskIntoConstraints(views: [
            shadowView,
            containerView,
            imageView
        ])
        
        shadowView.constraintAll(equalTo: self)
        containerView.constraintAll(equalTo: shadowView)
        imageView.constraintAll(equalTo: containerView)
    }
}
