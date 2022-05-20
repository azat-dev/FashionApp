//
//  ProductCellRounded.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 16.03.2022.
//

import Foundation
import UIKit

typealias ProductCellRoundedStyled = ProductCellRounded<ProductCellLayout, ProductCellRoundedStyles>

class ProductCellRounded<Layout: ProductCellLayoutable, Styles: ProductCellStylable>: ProductCell<Layout, Styles> {
    override class var reuseIdentifier: String {
        "ProductCellRounded"
    }
}
