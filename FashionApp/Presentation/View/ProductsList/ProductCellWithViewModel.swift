//
//  ProductCellWithViewModel.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 20.05.22.
//

import Foundation

protocol ProductCellWithViewModel: AnyObject {
    var viewModel: ProductCellViewModel? { get set }
}
