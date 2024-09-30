//
//  ForgetPasswordPresenter.swift
//  SeekIt
//
//  Created by g.b.rastogi on 30/09/24.
//

import Foundation

protocol ForgetPasswordPresenterInput: AnyObject {
    // Called when the login button is tapped in View
    func didTapForgetPassword(with username: String)
    
    // Called when the Forget Password process is successful
    func didForgetPasswordSuccessfully(with message: String)

    // Called when Forget Password fails with an error
    func didForgetPasswordFail(with message: String)
}

class ForgetPasswordPresenter {
    weak var view: ForgetPasswordViewInput?
    var router: ForgetPasswordRouterInput?
    var interactor: ForgetPasswordInteractorInput?
}

extension ForgetPasswordPresenter: ForgetPasswordPresenterInput {
    func didForgetPasswordSuccessfully(with message: String) {
        view?.showSuccessMessage(message)
        router?.navigateToLogin()
    }
    
    func didTapForgetPassword(with username: String) {
        view?.showLoading()
        interactor?.forgetPassword(username: username)
    }
    
    func didForgetPasswordFail(with message: String) {
        view?.showErrorMessage(message)
    }
}

extension ForgetPasswordPresenter: ForgetPasswordInteractorOutput {
    func forgetPasswordSucceeded(response: ForgetPasswordResponse) {
        view?.hideLoading()
        didForgetPasswordSuccessfully(with: response.message)
    }
    
    func forgetPasswordFailed(message: String) {
        view?.hideLoading()
        didForgetPasswordFail(with: message)
    }
}
