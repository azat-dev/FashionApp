//
//  ImageData.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 11.04.22.
//

import Foundation
import UIKit

struct ShowedProduct: Codable {
    var point: CGPoint
    var product: Product
}

struct ImageData: Codable {
    var name: String
    var showedProducts: [ShowedProduct]?
}
