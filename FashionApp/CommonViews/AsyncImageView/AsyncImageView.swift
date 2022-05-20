//
//  AsyncImageView.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 04.05.22.
//

import Foundation
import UIKit

class AsyncImageView<ImageView: ImageSettable & UIView>: UIView {
    private var viewModel = AsyncImageViewModel()
    var imageView = ImageView()
    var activityIndicator = UIActivityIndicatorView()
    
    var url: String? {
        set {
            viewModel.url.value = newValue
        }
        
        get {
            viewModel.url.value
        }
    }
    
    var loadImage: LoadImageFunction? {
        set {
            viewModel.loadImage.value = newValue
        }
        
        get {
            viewModel.loadImage.value
        }
    }
    
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
        viewModel.image.bind { [weak self] image, _ in
            guard let self = self else {
                return
            }
            
            guard let image = image else {
                DispatchQueue.main.async {
                    self.imageView.image = nil
                    self.activityIndicator.isHidden = false
                    self.imageView.isHidden = true
                    self.activityIndicator.startAnimating()
                }
                return
            }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.imageView.image = image
                self.imageView.isHidden = false
            }
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

// MARK: - Style
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
