//
//  ForgetPasswordInteractor.swift
//  SeekIt
//
//  Created by g.b.rastogi on 30/09/24.
//

import Foundation

protocol ForgetPasswordInteractorInput {
    func forgetPassword(username: String)
}

protocol ForgetPasswordInteractorOutput: AnyObject {
    func forgetPasswordSucceeded(response: ForgetPasswordResponse)
    func forgetPasswordFailed(message: String)
}

class ForgetPasswordInteractor: ForgetPasswordInteractorInput {
    weak var output: ForgetPasswordInteractorOutput!
    var worker: OnboardingWorkerProtocol?
    
    init(with worker: OnboardingWorkerProtocol) {
        self.worker = worker
    }
    
    func login(username: String, password: String) {
        worker?.forgetPasswordOutput = self
        let payload = LoginRequest(username: username, password: password)
        worker?.login(request: payload)
    }
    
    func forgetPassword(username: String) {
        worker?.forgetPasswordOutput  = self
        let payload = ForgetPasswordRequest(username: username)
        worker?.forgetPassword(request: payload)
    }
}

extension ForgetPasswordInteractor: ForgetPasswordWorkerOutput {
    func didSuccessForgetPassword(response: ForgetPasswordResponse) {
        self.output.forgetPasswordSucceeded(response: response)
    }
    
    func didFailedForgetPassword(error: ErrorResponse) {
        self.output.forgetPasswordFailed(message: error.message)
    }
}
