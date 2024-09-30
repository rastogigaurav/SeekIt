//
//  OnboardingWorker.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Moya
import Foundation

class OnboardingWorker: OnboardingWorkerProtocol {
    weak var loginOutput: LoginWorkerOutput?
    weak var forgetPasswordOutput: ForgetPasswordWorkerOutput?
    
    private var apiClient: APIClient

    public init (apiClient: APIClient = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func login(request: LoginRequest) {
        apiClient.requestObject(AuthenticationService.login(username: request.username, password: request.password), c: LoginResponse.self) {[weak self] result in
            switch result {
            case .success(let response):
                self?.loginOutput?.didSuccessLogin(response: response)
            case .failure(let error):
                self?.loginOutput?.didFailedLogin(error: error.errorResponse())
            }
        }
    }
    
    func forgetPassword(request: ForgetPasswordRequest) {
        apiClient.requestObject(AuthenticationService.forgetPassword(username: request.username), c: ForgetPasswordResponse.self) {[weak self] result in
            switch result {
            case .success(let response):
                self?.forgetPasswordOutput?.didSuccessForgetPassword(response: response)
            case .failure(let error):
                self?.forgetPasswordOutput?.didFailedForgetPassword(error: error.errorResponse())
            }
        }
    }
}
