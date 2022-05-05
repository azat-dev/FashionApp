//
//  ProductDetailsViewController+NavigationDelegate.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 20.04.22.
//

import Foundation
import UIKit

extension ProductDetailsViewController {
    class NavigationDelegate: NSObject, UINavigationControllerDelegate {
        func navigationController(
            _ navigationController: UINavigationController,
            animationControllerFor operation: UINavigationController.Operation,
            from fromVC: UIViewController,
            to toVC: UIViewController
        ) -> UIViewControllerAnimatedTransitioning? {
            guard
                let _ = fromVC as? ProductDetailsViewController,
                let _ = toVC as? FullScreenImageViewController
            else {
                return nil
            }
            
            switch operation {
            case .push:
                return FullScreenImageTransition(present: true)
            case .pop:
                return FullScreenImageTransition(present: false)
            default:
                return nil
            }
        }
    }
}
