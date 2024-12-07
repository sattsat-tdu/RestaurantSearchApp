//
//  UIApplication+Extensions.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/08
//  
//

import Foundation
import SwiftUI

extension UIApplication {
    
    static var loadingWindow: UIWindow?
    
    static func showLoading() {
        guard let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
        
        let newWindow = UIWindow(windowScene: windowScene)
        let vc = UIHostingController(rootView: LoadingView())
        
        vc.view.backgroundColor = .clear
        newWindow.rootViewController = vc
        newWindow.windowLevel = UIWindow.Level.alert + 1
        UIApplication.loadingWindow = newWindow
        newWindow.makeKeyAndVisible()
    }
    
    static func hideLoading() {
        loadingWindow = nil
    }
}
