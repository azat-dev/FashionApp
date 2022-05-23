//
//  AsyncImageView.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 04.05.22.
//

import Foundation
import UIKit

class AsyncImageView<ImageView: ImageSettable & UIView>: UIView {
    var viewModel: AsyncImageViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    var imageView = ImageView()
    var activityIndicator = UIActivityIndicatorView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        setupViews()
        layout()
        bindViewModel()
    }
}

// MARK: - Setup ViewModel

extension AsyncImageView {
    private func bindViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.image.observe(on: self) { [weak self] image in
            guard let self = self else {
                return
            }
            
            guard let image = image else {
                    self.imageView.image = nil
                    self.activityIndicator.isHidden = false
                    self.imageView.isHidden = true
                    self.activityIndicator.startAnimating()
                return
            }
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.imageView.image = image
            self.imageView.isHidden = false
        }
    }
}

// MARK: - Setup Views

extension AsyncImageView {
    private func setupViews() {
        addSubview(imageView)
        addSubview(activityIndicator)
    }
}

// MARK: - Styles

extension AsyncImageView {
    private func style() {
        activityIndicator.style = .medium
    }
}

// MARK: - Layout

extension AsyncImageView {
    private func layout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
}
