//
//  AppAssembly.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift

class AppAssembly {
    @MainActor static func configureApp() {
        // Set up any global configurations here
        setupAppearance()
        setupLocalization()
    }
    
    @MainActor static func setupAppearance() {
        // Configure the global appearance of your app (e.g., navigation bar style, colors)
        IQKeyboardManager.shared.enable = true
    }
    
    static func setupLocalization() {
        // Load any necessary localization settings
    }
    
    static func configureInitialViewController() -> UINavigationController {
        // Use the configurator to get the initial view controller
        return UINavigationController(rootViewController: OnboardingConfigurator.configureLoginScene())
    }
}
