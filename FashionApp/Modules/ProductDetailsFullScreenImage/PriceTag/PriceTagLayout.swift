//
//  PriceTagLayout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 11.04.22.
//

import Foundation
import UIKit
import SnapKit

protocol PriceTagLayoutable {
    static func apply(
        view: UIView,
        button: UIButton,
        labelShape: ShapedView,
        nameLabel: UILabel,
        priceLabel: UILabel
    )
}

class PriceTagLayout: PriceTagLayoutable {
    class func apply(
        view: UIView,
        button: UIButton,
        labelShape: ShapedView,
        nameLabel: UILabel,
        priceLabel: UILabel
    ) {
        
        UIView.disableAutoresizingMaskIntoConstraints(views: [
            labelShape,
        ])
        
        let spaceBetweenButtonAndLabel: CGFloat = 8
        
        nameLabel.layoutMargins = .init(top: -10, left: -15, bottom: 0, right: -15)
        priceLabel.layoutMargins = .init(top: 0, left: -5, bottom: -3, right: -10)
        
        button.snp.makeConstraints { make in
            make.right.equalTo(labelShape.snp.left).offset(-spaceBetweenButtonAndLabel).labeled("labelToButtonLeft")
            make.centerY.equalTo(nameLabel.snp.centerY).labeled("nameLabelToButtonVertical")
        }
        
        nameLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(labelShape.snp.top).labeled("nameLabelToShapeTop")
            make.leftMargin.equalTo(labelShape.snp.leftMargin).labeled("nameLabelToLeft")
            make.rightMargin.equalTo(labelShape.snp.rightMargin).labeled("nameLabelToRight")
        }
        
        priceLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(nameLabel.snp.bottom).labeled("priceLabelToNameLabelBottom")
            make.rightMargin.equalTo(nameLabel.snp.rightMargin).offset(-20).labeled("priceLabelToRightNameLabel")
            make.bottomMargin.equalTo(labelShape.snp.bottomMargin).labeled("priceLabelToShapeBottom")
        }
    }
}
