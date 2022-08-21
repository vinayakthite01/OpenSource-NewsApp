//
//  CustomAlert.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import Foundation
import UIKit

typealias CallbackType = () -> Void

/**
 *  Structure for Alert , that can be stacked
 */
struct AlertContext {
    
    let title: String?
    let message: String
    let actions: [CallbackType]
    let titles: [String]
    let actionStyle: UIAlertController.Style
}

class CustomAlert: NSObject, UIAlertViewDelegate {

    // MARK: - Properties
    
    // stack of Alert Event actions
    private var actions: [CallbackType]?
    
    // Stack of AlertContext
    private var alertStack = [AlertContext]()
    
    // MARK: - Super Class Methods
    init(actions: [CallbackType]?, alertStack: [AlertContext]) {
        Logger.log("Custom Alert Init")
        self.actions = actions
        self.alertStack = alertStack
    }
    
    /**
     Show alert message , if already another message is showing then its managed in Stack
     
     - parameter title:       Alert message title
     - parameter message:     Alert message
     - parameter actions:     array of actions
     - parameter titles:      titles of Actions
     - parameter actionStyle: Alert Actions Style
     */
    func showAlertView(title: String?, message: String, titles: [String], actionStyle: UIAlertController.Style = .alert) {
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: actionStyle)
        
        for counter in 0  ..< self.actions!.count {
            
            if let handler: CallbackType = self.actions?[counter] {
                
                let actionHandler = { [weak self] (action: UIAlertAction) -> Void in
                    
                    handler()
                    
                    self?.actions = nil
                    
                    if let alertContext = self?.alertStack.first {
                        // Showing other alert's if exist in the stack.
                        if let alertStackCount = self?.alertStack.count, alertStackCount > 0 {
                            let alertContext: AlertContext = alertContext
                            
                            self?.showAlertView(title: alertContext.title,
                                                message: alertContext.message,
                                                titles: alertContext.titles,
                                                actionStyle: alertContext.actionStyle)
                            
                            self?.alertStack.removeFirst()
                        }
                    }
                }
                let alertAction = UIAlertAction(title: titles[counter], style: .default, handler: actionHandler)
                
                alertController.addAction(alertAction)
            }
        }
        
        if actionStyle == UIAlertController.Style.actionSheet {
            let cancelHandler = {[weak self] (action: UIAlertAction) -> Void in
                
                self?.actions = nil
                if let alertContext = self?.alertStack.first {
                    if let alertStackCount = self?.alertStack.count, alertStackCount > 0 {
                        let alertContext: AlertContext = alertContext
                        
                        self?.showAlertView(title: alertContext.title,
                                            message: alertContext.message,
                                            titles: alertContext.titles,
                                            actionStyle: alertContext.actionStyle)
                        
                        self?.alertStack.removeFirst()
                    }
                }
            }
            
            let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler)
            alertController.view.tintColor = .black

            alertController.addAction(alertCancelAction)
        }
        
        if let rootController = UIApplication.shared.windows.first?.rootViewController {
            if let rootAsTabController = rootController as? UITabBarController, let selectedTabController = rootAsTabController.selectedViewController {
                if let presentedController = selectedTabController.presentedViewController {
                    presentedController.present(alertController, animated: true, completion: nil)
                } else {
                    selectedTabController.present(alertController, animated: true, completion: nil)
                }
            } else {
                if let presentedController = rootController.presentedViewController {
                    presentedController.present(alertController, animated: true, completion: nil)
                } else {
                    rootController.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
