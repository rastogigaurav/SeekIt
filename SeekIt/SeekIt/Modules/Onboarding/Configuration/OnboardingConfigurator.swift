//
//  OnboardingConfigurator.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

// OnboardingConfigurator.swift
import UIKit

class OnboardingConfigurator {    
    static func configureLoginScene() -> LoginViewController {
        // Load the storyboard
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        
        // Instantiate the LoginViewController
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            fatalError("LoginViewController not found in storyboard")
        }
        
        let presenter = LoginPresenter()
        let worker = OnboardingWorker()
        let interactor = LoginInteractor(with: worker)
        let router = LoginRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = viewController
        
        return viewController
    }
    
    static func configureForgetPasswordScene() -> ForgetPasswordViewController {
        // Load the storyboard
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as? ForgetPasswordViewController else {
            fatalError("ForgetPasswordViewController not found in storyboard")
        }
                
        let presenter = ForgetPasswordPresenter()
        let worker = OnboardingWorker()
        let interactor = ForgetPasswordInteractor(with: worker)
        let router = ForgetPasswordRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = viewController
        
        return viewController
    }
}

