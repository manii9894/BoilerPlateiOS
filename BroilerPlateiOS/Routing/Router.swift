//
//  Router.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 06/04/2022.
//

import UIKit
import SafariServices

class Router {
    
    static let shared = Router()
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
    
    func setRootVC() {
        setHomeRootVC()
    }
    
    func setHomeRootVC() {

        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeTabBarController")
        keyWindow?.rootViewController = rootVC

    }
    
    func hideTabBar() {
        
        if let vc = getTopVC() {
            if let tabBar = vc as? UITabBarController {
                tabBar.tabBar.isHidden = true
            }
        }
        
    }
    
    func showTabBar() {
        
        if let vc = getTopVC() {
            if let tabBar = vc as? UITabBarController {
                tabBar.tabBar.isHidden = false
            }
        }
        
    }
    
    func popVC() {
        
        if let vc = getTopVC() {
            if let tabBar = vc as? UITabBarController, let nav = tabBar.selectedViewController as? UINavigationController {
                nav.popViewController(animated: true)
            } else if let nav = vc.navigationController {
                nav.popViewController(animated: true)
            } else if let nav = vc as? UINavigationController {
                nav.popViewController(animated: true)
            }
        }
        
    }
    
    func popToTop() {
        
        if let vc = getTopVC() {
            if let tabBar = vc as? UITabBarController, let nav = tabBar.selectedViewController as? UINavigationController {
                nav.popToRootViewController(animated: true)
            } else if let nav = vc as? UINavigationController {
                nav.popToRootViewController(animated: true)
            } else if let nav = vc.navigationController {
                nav.popToRootViewController(animated: true)
            }
        }
        
    }
    
    func getTopVC() -> UIViewController? {
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
        
    }
    
    private func getPreviousVC(nav: UINavigationController) -> UIViewController? {
        
        let count = nav.viewControllers.count
        if count > 1 {
            return nav.viewControllers[count - 2]
        }
        return nil
        
    }
    
}
