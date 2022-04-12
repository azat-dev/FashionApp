//
//  PriceTag.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 11.04.22.
//

import Foundation
import UIKit

class PriceTag<Layout: PriceTagLayoutable, Styles: PriceTagStylable>: UIView {
    private var button = UIButton()
    private var labelShape = ShapedView()
    private var nameLabel = UILabel()
    private var priceLabel = UILabel()
    
    var viewModel: PriceTagViewModel! {
        didSet {
            bindViewModel(viewModel: viewModel)
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
        setupViews()
        style()
        layout()
    }
    
    @objc
    private func onTapButton() {
        
    }
}

// MARK: - Setup Views
extension PriceTag {
    private func setupViews() {
        button.addTarget(self, action: #selector(Self.onTapButton), for: .touchUpInside)
        
        
        labelShape.addSubview(nameLabel)
        labelShape.addSubview(priceLabel)
        
        addSubview(button)
        addSubview(labelShape)
    }
}

// MARK: - Bind the ViewModel
extension PriceTag {
    private func bindViewModel(viewModel: PriceTagViewModel) {
        viewModel.name.bind { newValue in
            self.nameLabel.text = newValue
        }
        
        viewModel.price.bind { newValue in
            self.priceLabel.text = newValue
        }
    }
}

// MARK: - Styles
extension PriceTag {
    private func style() {
        Styles.apply(button: button)
        Styles.apply(labelShape: labelShape)
        Styles.apply(nameLabel: nameLabel)
        Styles.apply(priceLabel: priceLabel)
    }
}

// MARK: - Layout
extension PriceTag {
    private func layout() {
        Layout.apply(
            view: self,
            button: button,
            labelShape: labelShape,
            nameLabel: nameLabel,
            priceLabel: priceLabel
        )
    }
}