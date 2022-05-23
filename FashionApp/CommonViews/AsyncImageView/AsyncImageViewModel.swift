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
    var progress = Observable(0.0)
    var isLoading = Observable(false)
    var isFailed = Observable(false)
    var didLoadImage: ((_ image: UIImage?) -> Void)?
    var imagesRepository: ImagesRepository
    
    init(imagesRepository: ImagesRepository) {
        self.imagesRepository = imagesRepository
        
        url.observe(on: self) { [weak self] url in
            guard let self = self else {
                return
            }
            
            self.updateImage(url: url)
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
        self.isFailed.value = false
        self.isLoading.value = true
        
        guard let url = url else {
            return
        }
        
        imagesRepository.fetchImage(
            with: url,
            size: nil
        ) { [weak self] result in
            
            guard
                let self = self,
                case .success(let data) = result,
                let image = UIImage(data: data)
            else {
                DispatchQueue.main.async {
                    self?.isFailed.value = false
                    self?.isLoading.value = false
                }
                return
            }
            
            
            DispatchQueue.main.async {
                self.image.value = image
                self.isLoading.value = false
                self.isFailed.value = false
                self.didLoadImage?(image)
            }
            
        } progress: { [weak self] (progress) -> Void in
            
            DispatchQueue.main.async {
                self?.progress.value = progress
            }
        }
    }
}
