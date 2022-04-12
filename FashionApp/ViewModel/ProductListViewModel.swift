//
//  ProductListViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.03.22.
//

import Foundation
import UIKit

private let defaultDescription = """
Short sleeve silk shirt with Hawaiian print. Classic
monogram, spread collar and corozo buttons.
100% silk. Made in Italy. With classic case
"""


let productShirt = Product(
    id: "1",
    brand: "NIKE",
    name: "Comfort Jacket",
    price: 450,
    description: defaultDescription,
    imageData: ImageData(
        name: "ImageTestHoodie",
        showedProducts: nil
    )
)

let product1 = Product(
    id: "1",
    brand: "NIKE",
    name: "Comfort Jacket",
    price: 450,
    description: defaultDescription,
    imageData: ImageData(
        name: "ImageTestHoodie",
        showedProducts: [
            ShowedProduct(
                point: CGPoint(x: 0.5, y: 0.5),
                product: productShirt
            )
        ]
    )
)

class ProductListViewModel {
    private var data: [Product] = [
        product1,
        Product(
            id: "2",
            brand: "NIKE",
            name: "Comfort Jacket",
            price: 450,
            description: defaultDescription,
            imageData: ImageData(
                name: "ImageTestHoodie",
                showedProducts: [
                    ShowedProduct(
                        point: CGPoint(x: 0.5, y: 0.5),
                        product: productShirt
                    )
                ]
            )
        ),
        Product(
            id: "3",
            brand: "NIKE",
            name: "Comfort Jacket",
            price: 450,
            description: defaultDescription,
            imageData: ImageData(
                name: "ImageTestHoodie",
                showedProducts: [
                    ShowedProduct(
                        point: CGPoint(x: 0.5, y: 0.5),
                        product: productShirt
                    )
                ]
            )
        ),
        Product(
            id: "4",
            brand: "NIKE",
            name: "Comfort Jacket",
            price: 450,
            description: defaultDescription,
            imageData: ImageData(
                name: "ImageTestHoodie",
                showedProducts: [
                    ShowedProduct(
                        point: CGPoint(x: 0.5, y: 0.5),
                        product: productShirt
                    )
                ]
            )
        ),
        Product(
            id: "5",
            brand: "NIKE",
            name: "Comfort Jacket",
            price: 450,
            description: defaultDescription,
            imageData: ImageData(
                name: "ImageTestHoodie",
                showedProducts: [
                    ShowedProduct(
                        point: CGPoint(x: 0.5, y: 0.5),
                        product: productShirt
                    )
                ]
            )
        ),
        Product(
            id: "6",
            brand: "NIKE",
            name: "Comfort Jacket",
            price: 450,
            description: defaultDescription,
            imageData: ImageData(
                name: "ImageTestHoodie",
                showedProducts: [
                    ShowedProduct(
                        point: CGPoint(x: 0.5, y: 0.5),
                        product: productShirt
                    )
                ]
            )
        ),
        Product(
            id: "7",
            brand: "NIKE",
            name: "Comfort Jacket",
            price: 450,
            description: defaultDescription,
            imageData: ImageData(
                name: "ImageTestHoodie",
                showedProducts: [
                    ShowedProduct(
                        point: CGPoint(x: 0.5, y: 0.5),
                        product: productShirt
                    )
                ]
            )
        ),
    ]
    
    var numberOfItems: Int {
        data.count
    }
    
    func getProduct(at index: Int) -> Product {
        return data[index]
    }
}
