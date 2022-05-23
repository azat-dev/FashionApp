//
//  ConnectionErrorView.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 07.05.22.
//

import Foundation
import UIKit

typealias ConnectionErrorViewStyled = ConnectionErrorView<ConnectionErrorViewLayout, ConnectionErrorViewStyles>

class ConnectionErrorView<Layout: ConnectionErrorViewLayoutable, Styles: ConnectionErrorViewStylable>: UIView {
    private var button = UIButton()
    private var imageView = UIImageView()
    private var descriptionLabel = UILabel()
    private var titleLabel = UILabel()
    private var contentGroup = UIStackView()
    
    typealias Callback = () -> Void
    var onReload: Callback?
    
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
        style()
    }
    
    @objc
    private func reload() {
        onReload?()
    }
}

extension ConnectionErrorView {
    private func setupViews() {
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(button)
        
        button.addTarget(
            self,
            action: #selector(Self.reload),
            for: .touchUpInside
        )
    }
}

// MARK: - Layout

extension ConnectionErrorView {
    private func layout() {
        Layout.apply(
            view: self,
            imageView: imageView,
            titleLabel: titleLabel,
            descriptionLabel: descriptionLabel,
            button: button
        )
    }
}

// MARK: - Styles

extension ConnectionErrorView {
    private func style() {
        Styles.apply(view: self)
        Styles.apply(imageView: imageView)
        Styles.apply(titleLabel: titleLabel)
        Styles.apply(descriptionLabel: descriptionLabel)
        Styles.apply(button: button)
    }
}
