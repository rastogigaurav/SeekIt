//
//  ForgetPasswordRouter.swift
//  SeekIt
//
//  Created by g.b.rastogi on 30/09/24.
//

import Foundation
import UIKit

protocol ForgetPasswordRouterInput {
    // Method to navigate to the home screen upon successful login
    func navigateToLogin()
}

class ForgetPasswordRouter {
    weak var viewController: BaseViewController?
}

extension ForgetPasswordRouter: ForgetPasswordRouterInput {
    func navigateToLogin() {
        // Implement the navigation logic to the login screen
    }
}

