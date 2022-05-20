//
//  AsyncImageViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 20.05.22.
//

import Foundation
import UIKit

class AsyncImageViewModel {
    var url: Observable<String?> = Observable(nil)
    var image: Observable<UIImage?> = Observable(nil)
    var loadImage: Observable<LoadImageFunction?> = Observable(nil)
    var progress = Observable(0.0)
    var isLoading = Observable(false)
    var isFailed = Observable(false)
    var didLoadImage: ((_ image: UIImage?) -> Void)?
    
    init() {
        url.bind { [weak self] (url, _) in
            guard let self = self else {
                return
            }
            
            self.updateImage(url: url)
        }
        
        loadImage.bind { [weak self] (loadImage, _) in
            guard
                let self = self,
                self.image.value == nil
            else {
                return
            }
            
            self.updateImage(url: self.url.value)
        }
    }
    
    private func didFinishLoading(_ error: Error?, _ image: UIImage?) {
        DispatchQueue.main.async {
            self.image.value = image
            self.isLoading.value = false
            self.isFailed.value = error != nil
        }
    }
    
    private func updateImage(url: String?) {
        self.image.value = nil
        self.progress.value = 0.0
        self.isLoading.value = true
        
        guard
            let loadImage = loadImage.value,
            let url = url
        else {
            return
        }
        
        loadImage(
            url,
            nil,
            {
                [weak self] (error, image) -> Void in
                
                DispatchQueue.main.async {
                    self?.image.value = image
                    self?.isLoading.value = false
                    self?.isFailed.value = error != nil
                    self?.didLoadImage?(image)
                }
            },
            {
                [weak self] (progress) -> Void in
                
                DispatchQueue.main.async {
                    self?.progress.value = progress
                }
            }
        )
    }
}
