//
//  DefaultImagesRepository.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 23.05.22.
//

import Foundation

final class DefaultImagesRepository {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension DefaultImagesRepository: ImagesRepository {
    func fetchImage(with imagePath: String, size: Size?, completion: @escaping (Result<Data, Error>) -> Void, progress: ((_ progress: Double) -> Void)? = nil) {
        let url: String
        
        let isRelativePath = imagePath.starts(with: "/")
        
        if isRelativePath  {
            url = "\(networkManager.baseUrl)\(imagePath)"
        } else {
            url = imagePath
        }
        
        networkManager.loadImage(
            url: url,
            size: size,
            completion: completion,
            progress: progress
        )
    }
}
