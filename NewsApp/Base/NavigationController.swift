//
//  NavigationController.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import UIKit

protocol NewsAppNavigationControllerProtocol {
    
    /// To push new view controller in stack
    /// - Parameters:
    ///   - viewController: View controller to push in stack
    ///   - animated: the animation status
    func push(viewController: UIViewController, animated: Bool)
    
    /// To pop current top view controller in stack
    /// - Parameters:
    ///   - animated: the animation status
    func pop(animated: Bool)
    
    /// To pop all view controller in stack except root
    /// - Parameters:
    ///   - animated: the animation status
    func popToRoot(animated: Bool)
    
    /// Pop specific view controller in stack
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - animated: the animation status
    func popTo(viewController: UIViewController, animated: Bool)
    
    /// Present ViewController without navigation controller, if presented with this function then push/present over new controller will not work
    /// - Parameters:
    ///   - viewController: ViewController class
    ///   - animated: with animation
    ///   - completion: completion handler
    func presentViewController(viewController: UIViewController,
                               animated: Bool, completion: (() -> Void)?)
    
    /// Present ViewController navigation controller, Use this function if presented view controller should have a NavigationController
    /// - Parameters:
    ///   - viewController: ViewController class
    ///   - modalPresentationStyle: UIModalPresentationStyle
    ///   - animated: with animation
    ///   - completion: completion handler
    ///    Return the object of MWHNavigationControllerProtocol which can be used to perform next push/present transmisions
    /// Returned MWHNavigationControllerProtocol needs to be persisted.
    func presentWithNavigator(viewController: UIViewController,
                              modalPresentationStyle: UIModalPresentationStyle,
                              completion: (() -> Void)?) -> NewsAppNavigationControllerProtocol
    
    /// This function will dismiss the navigation controller on which this is called
    /// - Parameters:
    ///   - completion: Optional coimpletion block
    ///   - animated: with animation
    func dismiss(completion: (() -> Void)?, animated: Bool)
}

/// Custome NewsAppNavigationController which is subclass of UINavigationController
final class NewsAppNavigationController: UINavigationController {
    
    /// View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = true
    }

}

/// NewsAppNavigationControllerProtocol
extension NewsAppNavigationController: NewsAppNavigationControllerProtocol {

    /// To push new view controller in stack
    /// - Parameters:
    ///   - viewController: View controller to push in stack
    ///   - animation: the animation status
    func push(viewController: UIViewController, animated: Bool) {
        self.pushViewController(viewController, animated: animated)
    }
    
    /// To pop current top view controller in stack
    /// - Parameters:
    ///   - animated: the animation status
    func pop(animated: Bool) {
        self.popViewController(animated: animated)
    }
    
    /// To pop all view controller in stack except root
    /// - Parameters:
    ///   - animated: the animation status
    func popToRoot(animated: Bool) {
        self.popToRootViewController(animated: true)
    }
    
    /// Pops to specific view controller in stack
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - animated: the animation status
    func popTo(viewController: UIViewController, animated: Bool) {
        self.popToViewController(viewController, animated: true)
    }
    
    /// Present ViewController without navigation controller
    /// - Parameters:
    ///   - viewController: ViewController class
    ///   - animated: with animation
    ///   - completion: completion handler
    func presentViewController(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.present(viewController, animated: animated, completion: completion)
    }
    
    /// Present ViewController with navigation controller
    /// - Parameters:
    ///   - navigationController: navigation controller object
    ///   - modalPresentationStyle: UIModalPresentationStyle
    ///   - completion: completion handler
    func presentWithNavigator(viewController: UIViewController,
                              modalPresentationStyle: UIModalPresentationStyle,
                              completion: (() -> Void)?) -> NewsAppNavigationControllerProtocol {
        let newNavigationController = NewsAppNavigationController(rootViewController: viewController)
        newNavigationController.modalPresentationStyle = modalPresentationStyle
        self.presentViewController(viewController: newNavigationController,
                                   animated: true, completion: completion)
        return newNavigationController
    }
    
    /// This function will dismiss the navigation controller on which this is called
    /// - Parameter completion: Optional coimpletion block
    func dismiss(completion: (() -> Void)?, animated: Bool) {
        self.dismiss(animated: animated, completion: completion)
    }
}

/// UINavigationControllerDelegate
extension NewsAppNavigationController: UINavigationControllerDelegate {
    /// Navigation Controller will show
    /// - Parameters:
    ///   - navigationController: navigation
    ///   - viewController: show view
    ///   - animated: with animation
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let coordinator = navigationController.topViewController?.transitionCoordinator {
            coordinator.notifyWhenInteractionChanges { (context) in
                print("Is cancelled: \(context.isCancelled)")
                if !context.isCancelled {
                    /* NotificationCenter.default.post(name: .swipeBack, object: nil) */
                }
            }
        }
    }
}
