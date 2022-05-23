//
//  LoadImageFunction.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 20.05.22.
//

import Foundation
import UIKit

typealias LoadImageFunction = (
    _ url: String,
    _ size: Size?,
    _ completion: @escaping (_ error: Error?, _ image: UIImage?) -> Void,
    _ progress: ((_ progress: Double) -> Void)?
) -> Void
