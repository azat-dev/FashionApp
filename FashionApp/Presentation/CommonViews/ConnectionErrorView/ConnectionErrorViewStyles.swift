//
//  ConnectionErrorViewStyles.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 07.05.22.
//

import Foundation
import UIKit

protocol ConnectionErrorViewStylable {
    static func apply(view: UIView)
    static func apply(imageView: UIImageView)
    static func apply(titleLabel: UILabel)
    static func apply(descriptionLabel: UILabel)
    static func apply(button: UIButton)
}

class ConnectionErrorViewStyles: ConnectionErrorViewStylable {
    
    static func apply(view: UIView) {
    }
    
    static func apply(imageView: UIImageView) {
        imageView.image = UIImage(systemName: "wifi.exclamationmark")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
    }
    
    static func apply(titleLabel: UILabel) {
        titleLabel.text = "Connection error"
        titleLabel.textAlignment = .center
        titleLabel.font = Fonts.RedHatDisplay.bold.preferred(with: .headline)
    }
    
    static func apply(descriptionLabel: UILabel) {
        descriptionLabel.text = "Something went wrong"
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = Fonts.RedHatDisplay.medium.preferred(with: .subheadline)
    }
    
    static func apply(button: UIButton) {
        button.setTitle("Reload", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
    }
}
