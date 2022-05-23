//
//  ImagesRepository.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 23.05.22.
//

import Foundation

struct Size {
    var width: Int
    var height: Int
}

protocol ImagesRepository {
    func fetchImage(
        with imagePath: String,
        size: Size?,
        completion: @escaping (Result<Data, Error>) -> Void,
        progress: ((_ progress: Double) -> Void)?
    )
}
