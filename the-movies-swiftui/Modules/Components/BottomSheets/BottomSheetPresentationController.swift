//
//  APIErrorBottomSheet.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 26/08/25.
//

import UIKit

class BottomSheetPresentationController: UIPresentationController {
    
    var dimmingView = UIView()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        dimmingView.backgroundColor = .black.withAlphaComponent(0.3)
        dimmingView.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(diTapDismiss))
        dimmingView.addGestureRecognizer(tapGesture)
    }
    
    @objc func diTapDismiss() {
        self.presentedViewController.dismiss(animated: true)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        let targetSize = CGSize(width: containerView.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)
        let fittingHeight = presentedViewController.view.systemLayoutSizeFitting(
            targetSize
        ).height
        
        let topMargin = CGFloat(100)
        let maximumHeight = containerView.bounds.height - topMargin
        
        let height = min(fittingHeight, maximumHeight)
        
        return CGRect(
            x: 0,
            y: containerView.bounds.height - height,
            width: containerView.bounds.width,
            height: height
        )
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        dimmingView.frame = containerView.bounds
        containerView.addSubview(dimmingView)
        containerView.insertSubview(dimmingView, at: 0)
        
        presentedViewController.transitionCoordinator?.animate { _ in
            self.dimmingView.alpha = 1
        }
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate { _ in
            self.dimmingView.alpha = 0
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}

class BottomSheetTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
