//
//  LoginRouter.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import UIKit

protocol LoginRouterInput {
    // Method to navigate to the home screen upon successful login
    func navigateToHome()

    // Method to navigate to the "Forgot Password" screen
    func navigateToForgotPassword()

    // Method to navigate to the "Terms and Conditions" screen
    func navigateToTermsAndConditions()

    // Method to handle any navigation that should happen on login failure (optional)
    func handleLoginFailure()
}

class LoginRouter {
    weak var viewController: BaseViewController?
}

extension LoginRouter: LoginRouterInput {
    func navigateToHome() {
        // Implement the navigation logic to the home screen
    }
    
    func navigateToForgotPassword() {
        // Implement the navigation logic to the home screen
        let destinationViewController = OnboardingConfigurator.configureForgetPasswordScene()
        self.viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func navigateToTermsAndConditions() {
        // Implement the navigation logic to the home screen
    }
    
    func handleLoginFailure() {
        // Implement the navigation logic to the home screen
    }
}
