//
//  ProductDetailsViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 16.03.2022.
//

import Foundation
import UIKit
import UIImageViewAlignedSwift

class ProductDetailsViewController<Layout: ProductDetailsViewLayoutable, Styles: ProductDetailsViewStylable>: UIViewController {
    typealias FullScreenImageViewController = ProductDetailsFullScreenImage<ProductDetailsFullScreenImageStyles, ProductDetailsFullScreenImageLayout>
    
    private var backButton = UIButton(type: .system)
    private var scrollView = UIScrollView()
    private var imageShadow = ShadowView()
    private var imageContainer = ShapedView()
    private var imageView = UIImageViewAligned()
    private var titleLabel = UILabel()
    private var brandLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var cartButton = UIButton(type: .system)
    private var imageDescriptionButton = UIButton(type: .system)
    private var contentView = UIView()

    private var fullScreenImageTransitionDelegate = FullScreenImageTransitionDelegate()
    
    var viewModel: ProductViewModel!
    var openedImage: UIImageView?
    var openedImageFrame: CGRect? {
        guard let openedImage = openedImage else {
            return nil
        }
        
        return view.convert(openedImage.frame, to: nil)
    }

    init(viewModel: ProductViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupViews()
        style()
        layout()
        bindViewModel()
    }
    
    @objc
    private func goBack() {
        guard let navigationController = navigationController else {
            dismiss(animated: true)
            return
        }
        
        
        navigationController.popViewController(animated: true)
    }
    
    @objc
    private func openImage() {
        let vc = FullScreenImageViewController(viewModel: viewModel)
        
        openedImage = imageView
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = fullScreenImageTransitionDelegate
        present(vc, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - Set up views
private extension ProductDetailsViewController {
    private func setupViews() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.systemBackground
        
        backButton.addTarget(self, action: #selector(Self.goBack), for: .touchUpInside)
        imageDescriptionButton.addTarget(self, action: #selector(Self.openImage), for: .touchUpInside)
        imageContainer.addSubview(imageView)
        imageShadow.addSubview(imageContainer)
        contentView.addSubview(imageShadow)
        
        contentView.addSubview(imageDescriptionButton)
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(brandLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(cartButton)
        imageContainer.addSubview(backButton)
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
}

// MARK: - Bind ViewModel
private extension ProductDetailsViewController {
    private func bindViewModel() {
        viewModel.image.bind {
            [weak self] in
            self?.imageView.image = $0
        }
        
        viewModel.title.bind {
            [weak self] in
            self?.titleLabel.text = $0
        }
        
        viewModel.brand.bind {
            [weak self] in
            self?.brandLabel.text = $0
        }
        
        viewModel.description.bind {
            [weak self] in
            self?.descriptionLabel.text = $0
        }
    }
}

// MARK: - Layout
private extension ProductDetailsViewController {
    func layout() {
        Layout.apply(
            view: view,
            scrollView: scrollView,
            contentView: contentView,
            imageShadow: imageShadow,
            imageContainer: imageContainer,
            imageView: imageView,
            titleLabel: titleLabel,
            brandLabel: brandLabel,
            descriptionLabel: descriptionLabel,
            backButton: backButton,
            imageDescriptionButton: imageDescriptionButton,
            cartButton: cartButton
        )
    }
}

// MARK: - Assign styles
private extension ProductDetailsViewController {
    func style() {
        Styles.apply(scrollView: scrollView)
        Styles.apply(contentView: contentView)
        Styles.apply(imageShadow: imageShadow)
        Styles.apply(imageContainer: imageContainer)
        Styles.apply(imageView: imageView)
        Styles.apply(titleLabel: titleLabel)
        Styles.apply(brandLabel: brandLabel)
        Styles.apply(descriptionLabel: descriptionLabel)
        Styles.apply(cartButton: cartButton)
        Styles.apply(backButton: backButton)
        Styles.apply(imageDescriptionButton: imageDescriptionButton)
    }
}

// MARK: - ProductDetailsFullScreenImage Transition
private extension ProductDetailsViewController {
    
    private class FullScreenImageTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
        func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return FullScreenImageAnimatorOpen()
        }
        
        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return nil
        }
    }
    
    private class FullScreenImageAnimatorOpen: NSObject, UIViewControllerAnimatedTransitioning {
        private var duration: TimeInterval = 0.3
        
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return duration
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            guard transitionContext.isAnimated else {
                transitionContext.completeTransition(true)
                return
            }

            let container = transitionContext.containerView
            let fromVC = transitionContext.viewController(forKey: .from)
            let navigationVC = fromVC as? UINavigationController
                
            guard
                let fromVC = (navigationVC?.topViewController ?? fromVC) as? ProductDetailsViewController<Layout, Styles>,
                let toVC = transitionContext.viewController(forKey: .to),
                let toView = transitionContext.view(forKey: .to)
            else {
                transitionContext.completeTransition(true)
                return
            }

            guard
                let window = container.window,
                let originalOpenedImageFrame = fromVC.openedImageFrame
            else {
                transitionContext.completeTransition(true)
                return
            }

            
            let targetPosition = toView.center

            let openedImageFrame = window.convert(originalOpenedImageFrame, to: container)
            let initialScaleX = openedImageFrame.width / toView.frame.width
            let initialScaleY = openedImageFrame.height / toView.frame.height


            container.addSubview(toView)
            toView.transform = CGAffineTransform(scaleX: initialScaleX, y: initialScaleY)
            toView.frame.origin = openedImageFrame.origin
            toView.layer.cornerRadius = 20

            UIView.animate(
                withDuration: duration,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    toView.transform = .identity
                    toView.center = targetPosition
                },
                completion: { _ in
                    transitionContext.completeTransition(true)
                })
        }
    }
}
