//
//  UIViewController+Extension.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Check if a view controller is presented modally
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    /**
     Show alert message , if already another message is showing then its managed in Stack
     
     - parameter title:       Alert message title
     - parameter message:     Alert message
     - parameter actions:     array of actions
     - parameter titles:      titles of Actions
     - parameter actionStyle: Alert Actions Style
     */
    func showAlertView(title: String?, message: String, actions: [CallbackType] = [ { } ], titles: [String], actionStyle: UIAlertController.Style) {
        
        let alertStack = [AlertContext]()
        let customAlert = CustomAlert(actions: actions, alertStack: alertStack)
        
        customAlert.showAlertView(title: title, message: message, titles: titles)
    }
}
