//
//  ProductDetailsControllerViewLayout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift
import SnapKit

protocol ProductDetailsViewControllerLayout {
    func apply(
        view: UIView,
        scrollView: UIScrollView,
        contentView: UIView,
        imageView: ImageViewShadowed,
        titleLabel: UILabel,
        brandLabel: UILabel,
        descriptionLabel: UILabel,
        backButton: UIButton,
        imageDescriptionButton: UIButton,
        cartButton: UIButton
    )
}

struct DefaultProductDetailsViewControllerLayout: ProductDetailsViewControllerLayout {
    func apply(
        view: UIView,
        scrollView: UIScrollView,
        contentView: UIView,
        imageView: ImageViewShadowed,
        titleLabel: UILabel,
        brandLabel: UILabel,
        descriptionLabel: UILabel,
        backButton: UIButton,
        imageDescriptionButton: UIButton,
        cartButton: UIButton
    ) {
        contentView.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.centerX.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.bottom.greaterThanOrEqualTo(scrollView.snp.bottom)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide)
            make.left.equalTo(contentView.layoutMarginsGuide)
            make.right.equalTo(contentView.layoutMarginsGuide)
            make.height.equalTo(imageView.snp.width).multipliedBy(1.37)
            
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        imageDescriptionButton.snp.makeConstraints { make in
            make.bottom.equalTo(imageView).offset(-20)
            make.right.equalTo(imageView).offset(-18)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(imageView).offset(10)
            make.top.equalTo(imageView).offset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.layoutMarginsGuide)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.layoutMarginsGuide)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(contentView.layoutMarginsGuide)
            make.bottom.equalTo(contentView.layoutMarginsGuide)
        }
        
        cartButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.layoutMarginsGuide.snp.horizontalEdges)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        imageView.imageView.snp.removeConstraints()
        
        imageView.imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(imageView.containerView)
            make.height.equalTo(imageView.containerView).multipliedBy(0.98)
            make.centerX.equalTo(imageView.containerView)
            make.bottom.equalTo(imageView.containerView)
        }
    }
}
