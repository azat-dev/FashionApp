//
//  AsyncImageView.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 04.05.22.
//

import Foundation
import UIKit

protocol ImageSettable: AnyObject {
    var image: UIImage? { get set }
}

protocol ImageInitable: AnyObject {
    
}

class AsyncImageView<ImageView: ImageSettable & UIView>: UIView {
    var viewModel = ViewModel()
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
    
    var imageLoader: ImageLoader? {
        set {
            viewModel.imageLoader.value = newValue
        }
        
        get {
            viewModel.imageLoader.value
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
        bindViewModel()
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(activityIndicator)
        
        activityIndicator.style = .medium
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
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

extension AsyncImageView {
    class ViewModel {
        var url: Observable<String?> = Observable(nil)
        var image: Observable<UIImage?> = Observable(nil)
        var imageLoader: Observable<ImageLoader?> = Observable(nil)
        
        init() {
            url.bind { [weak self] (url, _) in
                guard let self = self else {
                    return
                }
                
                self.updateImage(url: url)
            }
            
            imageLoader.bind { [weak self] (imageLoader, _) in
                guard
                    let self = self,
                    self.image.value == nil
                else {
                    return
                }
                
                self.updateImage(url: self.url.value)
            }
        }
        
        private func updateImage(url: String?) {
            self.image.value = nil
            
            guard
                let url = url,
                let loader = imageLoader.value
            else {
                return
            }
            
            loader.load(url: url, size: nil) { [weak self] error, image in
                DispatchQueue.main.async {
                    self?.image.value = image
                }
            }
        }
    }
}
