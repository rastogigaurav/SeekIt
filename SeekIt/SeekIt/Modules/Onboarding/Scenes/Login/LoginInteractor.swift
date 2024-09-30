//
//  LoginInteractor.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Foundation

protocol LoginInteractorInput {
    func login(username: String, password: String)
}

protocol LoginInteractorOutput: AnyObject {
    func loginSucceeded()
    func loginFailed(message: String)
}

class LoginInteractor: LoginInteractorInput {
    weak var output: LoginInteractorOutput!
    var worker: OnboardingWorkerProtocol?
    
    init(with worker: OnboardingWorkerProtocol) {
        self.worker = worker
    }
    
    func login(username: String, password: String) {
        worker?.loginOutput = self
        let payload = LoginRequest(username: username, password: password)
        worker?.login(request: payload)
    }    
}

extension LoginInteractor: LoginWorkerOutput {
    func didSuccessLogin(response: LoginResponse) {
        self.output.loginSucceeded()
    }
    
    func didFailedLogin(error: ErrorResponse) {
        self.output.loginFailed(message: error.message)
    }
}
