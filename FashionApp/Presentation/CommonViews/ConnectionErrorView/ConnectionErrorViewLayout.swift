//
//  ConnectionErrorViewLayout.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 07.05.22.
//

import Foundation
import UIKit

protocol ConnectionErrorViewLayoutable {
    static func apply(
        view: UIView,
        imageView: UIImageView,
        titleLabel: UILabel,
        descriptionLabel: UILabel,
        button: UIButton
    )
}

class ConnectionErrorViewLayout: ConnectionErrorViewLayoutable {
    static func apply(view: UIView, imageView: UIImageView, titleLabel: UILabel, descriptionLabel: UILabel, button: UIButton) {
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view).priority(.low)
            make.centerX.equalTo(view)
            make.height.horizontalEdges.equalTo(view)
            make.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.horizontalEdges.equalTo(view)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalTo(view)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view)
            make.bottom.equalTo(view).priority(.low)
        }
    }
}
