//
//  Product.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 04.03.2022.
//

import Foundation

struct Product: Codable {
    var id: String
    var brand: String
    var name: String
    var price: Float
    var description: String
    var imageData: ImageData?
    var image: String
}
