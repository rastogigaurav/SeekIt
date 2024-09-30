//
//  OnboardingWorkerProtocol.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Foundation

protocol OnboardingWorkerProtocol {
    var loginOutput: LoginWorkerOutput? {get set}
    var forgetPasswordOutput: ForgetPasswordWorkerOutput? {get set}
    
    func login(request: LoginRequest)
    func forgetPassword(request: ForgetPasswordRequest)
}

protocol LoginWorkerOutput: AnyObject {
    //Login
    func didSuccessLogin(response: LoginResponse)
    func didFailedLogin(error: ErrorResponse)
}

protocol ForgetPasswordWorkerOutput: AnyObject {
    //Logout
    func didSuccessForgetPassword(response: ForgetPasswordResponse)
    func didFailedForgetPassword(error: ErrorResponse)
}
