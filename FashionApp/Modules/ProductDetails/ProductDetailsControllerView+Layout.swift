//
//  ProductDetailsControllerView+Layout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit

extension ProductDetailsViewController {
    func layout(
        scrollView: UIScrollView,
        contentView: UIView,
        shapedImageView: ShapedImageView,
        titleLabel: UILabel,
        brandLabel: UILabel,
        descriptionLabel: UILabel,
        backButton: UIButton,
        imageDescriptionButton: UIButton,
        cartButton: UIButton
    ) {
        scrollView.frame = view.frame
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false

        imageDescriptionButton.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.98),

            shapedImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            shapedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            shapedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            shapedImageView.heightAnchor.constraint(equalTo: shapedImageView.widthAnchor, multiplier: 1.37, constant: 0),

            imageDescriptionButton.bottomAnchor.constraint(equalTo: shapedImageView.bottomAnchor, constant: -20),
            imageDescriptionButton.trailingAnchor.constraint(equalTo: shapedImageView.trailingAnchor, constant: -18),

            backButton.topAnchor.constraint(equalTo: shapedImageView.topAnchor, constant: 15),
            backButton.leadingAnchor.constraint(equalTo: shapedImageView.leadingAnchor, constant: 10),

            titleLabel.topAnchor.constraint(equalTo: shapedImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            brandLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            brandLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            cartButton.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            cartButton.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),

            cartButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cartButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}

