//
//  ProductDetailsViewController+FullScreenImageTransition.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 19.04.22.
//

import Foundation
import UIKit

private func extractViewController<T>(viewController: UIViewController) -> T? {
    
    let navigationVC = viewController as? UINavigationController
    return (navigationVC?.topViewController ?? viewController) as? T
}

extension ProductDetailsViewController {
    
    class FullScreenImageTransition: NSObject, UIViewControllerAnimatedTransitioning {
        private var duration: TimeInterval = 0.5
        
        private var imageBackgroundView = UIView()
        private var backgroundView = UIView()
        
        private var container: UIView!
        private var originalImage: ImageViewShadowed!
        private var fullscreenImage: UIView!
        private var fullscreenImageSnapshot: UIView!
        private var detailsVC: ProductDetailsViewController!
        private var fullscreenImageVC: ProductDetailsFullScreenImageViewController!
        private var fullscreenRootView: UIView!
        private var detailsRootView: UIView!
        
        var isPresenting: Bool
        
        init(present: Bool) {
            self.isPresenting = present
        }
        
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return duration
        }
        
        private func setupViews(using transitionContext: UIViewControllerContextTransitioning) -> Bool {
            
            guard
                let fromVC = transitionContext.viewController(forKey: .from),
                let toVC = transitionContext.viewController(forKey: .to)
            else {
                return false
            }
            
            guard
                let detailsVC: ProductDetailsViewController = extractViewController(viewController: isPresenting ? fromVC : toVC),
                let fullscreenImageVC: ProductDetailsFullScreenImageViewController = extractViewController(viewController: isPresenting ? toVC : fromVC)
            else {
                return false
            }
            
            self.container = transitionContext.containerView
            self.detailsVC = detailsVC
            self.fullscreenImageVC = fullscreenImageVC
            self.fullscreenRootView = fullscreenImageVC.view
            self.detailsRootView = detailsVC.view
            
            return true
        }
        
        private func setupTransitionViews(using transitionContext: UIViewControllerContextTransitioning) -> Bool {

            if isPresenting {
                fullscreenRootView.alpha = 0
                container.addSubview(fullscreenRootView)
                fullscreenRootView.frame = transitionContext.finalFrame(for: fullscreenImageVC)
            } else {
                detailsRootView.frame = transitionContext.finalFrame(for: detailsVC)
                container.addSubview(detailsRootView)
            }

            fullscreenRootView.layoutIfNeeded()
            fullscreenImage = fullscreenImageVC.imageView

            guard
                let sourceImage = detailsVC.openedImage,
                let targetImageSnapshot = fullscreenImage.snapshotView(afterScreenUpdates: true)
            else {
                return false
            }

            targetImageSnapshot.translatesAutoresizingMaskIntoConstraints = false

            self.originalImage = sourceImage
            self.fullscreenImageSnapshot = targetImageSnapshot

            container.addSubview(backgroundView)
            container.addSubview(imageBackgroundView)
            container.addSubview(fullscreenImageSnapshot)
            container.bringSubviewToFront(fullscreenRootView)
            return true
        }
        
        private func animate(using transitionContext: UIViewControllerContextTransitioning) {
            
            let opaque: CGFloat = 1
            let transparent: CGFloat = 0
            
            let originalImageFrame = originalImage.convert(originalImage.containerView.frame, to: container)
            let fullscreenImageFrame = fullscreenImage.superview!.convert(fullscreenImage.frame, to: container)
            
            let initialScale = max(originalImageFrame.width, originalImageFrame.height) / max(fullscreenImageFrame.width, fullscreenImageFrame.height)
            
            let initialFrame = CGRect(
                x: originalImageFrame.midX - fullscreenImageFrame.width * initialScale / 2,
                y: originalImageFrame.midY - fullscreenImageFrame.height * initialScale / 2,
                width: fullscreenImageFrame.width * initialScale,
                height: fullscreenImageFrame.height * initialScale
            )
            
            let imageCornerRadius = originalImage.containerView.layer.cornerRadius
            
            backgroundView.backgroundColor = detailsVC.view.backgroundColor
            backgroundView.frame = container.frame
            imageBackgroundView.backgroundColor = originalImage.containerView.backgroundColor
            
            if isPresenting {
                fullscreenImageSnapshot.alpha = opaque
                fullscreenImageSnapshot.frame = initialFrame
                
                backgroundView.alpha = transparent
                imageBackgroundView.alpha = opaque
                imageBackgroundView.frame = originalImageFrame
                imageBackgroundView.layer.cornerRadius = imageCornerRadius
                
                fullscreenRootView.alpha = transparent
            } else {
                fullscreenImageSnapshot.frame = fullscreenImageFrame
                fullscreenImageSnapshot.alpha = transparent
                
                backgroundView.alpha = opaque
                imageBackgroundView.alpha = transparent
                imageBackgroundView.frame = fullscreenRootView.frame
                imageBackgroundView.layer.cornerRadius = 0
                
                fullscreenRootView.alpha = opaque
            }
            
            UIView.animateKeyframes(
                withDuration: duration,
                delay: 0,
                options: [],
                animations: {
                    
                    UIView.addKeyframe(
                        reverse: !self.isPresenting,
                        withRelativeStartTime: 0,
                        relativeDuration: 0.2,
                        animations: {
                            self.backgroundView.alpha = opaque
                            self.fullscreenImageSnapshot.alpha = opaque
                        },
                        reversedAnimations: {
                            self.backgroundView.alpha = transparent
                            self.fullscreenImageSnapshot.alpha = transparent
                        },
                        name: "Background animation"
                    )
                    
                    UIView.addKeyframe(
                        reverse: !self.isPresenting,
                        withRelativeStartTime: 0,
                        relativeDuration: self.isPresenting ? 0.6 : 1,
                        animations: {
                            self.imageBackgroundView.frame = self.fullscreenRootView.frame
                            self.imageBackgroundView.layer.cornerRadius = 0
                            self.fullscreenImageSnapshot.frame = fullscreenImageFrame
                        },
                        reversedAnimations: {
                            self.imageBackgroundView.frame = originalImageFrame
                            self.imageBackgroundView.layer.cornerRadius = imageCornerRadius
                            self.fullscreenImageSnapshot.frame = initialFrame
                        },
                        name: "Fullscreen image resizing"
                    )
                    
                    if !self.isPresenting {
                        UIView.addKeyframe(
                            reverse: !self.isPresenting,
                            withRelativeStartTime: 0.6,
                            relativeDuration: 0.4,
                            animations: {
                                self.fullscreenImageSnapshot.alpha = transparent
                            },
                            reversedAnimations: {
                                self.fullscreenRootView.alpha = transparent
                                self.fullscreenImageSnapshot.alpha = opaque
                                self.imageBackgroundView.alpha = opaque
                            },
                            name: "Show root view"
                        )
                    }
                },
                completion: { _ in
                    self.fullscreenRootView.alpha = opaque
                    self.backgroundView.removeFromSuperview()
                    self.imageBackgroundView.removeFromSuperview()
                    self.fullscreenImageSnapshot.removeFromSuperview()
                    transitionContext.completeTransition(true)
                }
            )
        }
            
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            guard transitionContext.isAnimated else {
                transitionContext.completeTransition(true)
                return
            }
            
            guard setupViews(using: transitionContext) else {
                transitionContext.completeTransition(true)
                return
            }
            
            
            guard setupTransitionViews(using: transitionContext) else {
                transitionContext.completeTransition(true)
                return
            }
            
            animate(using: transitionContext)
        }
    }
}
