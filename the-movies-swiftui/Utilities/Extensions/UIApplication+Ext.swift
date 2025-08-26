//
//  UIApplication+Ext.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 26/08/25.
//

import UIKit

extension UIApplication {
    func topViewController(
        base: UIViewController? = UIApplication.shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController
    ) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        return base
    }
}
