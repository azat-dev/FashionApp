//
//  CGRect+Utils.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 18.04.22.
//

import Foundation
import UIKit

extension CGRect {
    var center: CGPoint {
        set {
            self.origin = CGPoint(
                x: self.midX - self.width,
                y: self.midY - self.height
            )
        }
        
        get {
            CGPoint(
                x: self.midX,
                y: self.midY
            )
        }
    }
    
//    init(center: CGPoint, size: CGSize) {
//        self.init(
//            origin: <#T##CGPoint#>, size: <#T##CGSize#>
//    }
}
