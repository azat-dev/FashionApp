//
//  UIView+Animation.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 19.04.22.
//

import Foundation
import UIKit

extension UIView {
    static func addKeyframe(
        reverse: Bool,
        withRelativeStartTime: Double,
        relativeDuration: Double,
        animations: @escaping () -> Void,
        reversedAnimations: @escaping () -> Void,
        name: String = ""
    ) {
        let startTime = reverse ? 1 - (withRelativeStartTime + relativeDuration) : withRelativeStartTime
        
        UIView.addKeyframe(
            withRelativeStartTime: startTime,
            relativeDuration: relativeDuration,
            animations: reverse ? reversedAnimations : animations
        )
    }
}
