//
//  LoginPresenter.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Foundation

protocol LoginPresenterInput: AnyObject {
    // Called when the login button is tapped in View
    func didTapLogin(with username: String, and password: String)
    
    // Called when the login button is tapped in View
    func didTapForgetPassword(with username: String)
    
    // Called when the login process is successful
    func didLoginSuccessfully()

    // Called when login fails with an error
    func didLoginFail(with message: String)
}

class LoginPresenter {
    weak var view: LoginViewInput?
    var router: LoginRouterInput?
    var interactor: LoginInteractorInput?
}

extension LoginPresenter: LoginPresenterInput {
    func didTapLogin(with username: String, and password: String) {
        view?.showLoading()
        interactor?.login(username: username, password: password)
    }
    
    func didTapForgetPassword(with username: String) {
        router?.navigateToForgotPassword()
    }
    
    func didLoginSuccessfully() {
        view?.showSuccessMessage(L10n.onboardingLoginLoggedInSuccessMessage)
        router?.navigateToHome()
    }
    
    func didLoginFail(with message: String) {
        view?.showErrorMessage(message)
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func loginSucceeded() {
        view?.hideLoading()
        didLoginSuccessfully()
    }
    
    func loginFailed(message: String) {
        view?.hideLoading()
        didLoginFail(with: message)
    }
}
