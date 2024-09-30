//
//  AuthenticationService.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Moya
import Foundation

enum AuthenticationService {
    case login(username: String, password: String)
    case forgetPassword(username: String)
    case logout
}

extension AuthenticationService: LocalizableTargetType {
    var baseURL: URL {
        if Application.isLocalEnvironment {
            print("GR: baseURL \(Bundle.main.bundleURL)")
            return Bundle.main.bundleURL
        } else {
            print("GR: baseURL \(String(describing: URL(string: NetworkConfig.shared.infoForKey(ConfigKeys.baseUrl.rawValue, defaultValue: ""))?.host()))")
            return URL(string: NetworkConfig.shared.infoForKey(ConfigKeys.baseUrl.rawValue, defaultValue: ""))!
        }
    }
    
    var path: String {
        if isLocalEnvironment, let localFile = localResponseFileName {
            return localFile // This can be used later in the APIClient for loading local JSON
        } else {
            switch self {
            case .login:
                return ServicePaths.authLogin
            case .forgetPassword:
                return ServicePaths.authForgetPassword
            case .logout:
                return ServicePaths.authLogout
            }
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .logout, .forgetPassword:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .login(username, password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: JSONEncoding.default)
        case let .forgetPassword(username):
            return .requestParameters(parameters: ["username": username], encoding: JSONEncoding.default)
        case .logout:
            return .requestPlain // No parameters needed for logout
        }
    }
    
    var headers: [String : String]? {
        return CommonHeaders.defaultHeaders()
    }
    
    var isLocalEnvironment: Bool {
        return Application.isLocalEnvironment
    }
    
    var localResponseFileName: String? {
        switch self {
        case .login:
            return "login_success" // or "login_failure" based on the scenario
        case .forgetPassword:
            return "forget_password_success"
        case .logout:
            return "logout_success"
        }
    }
    
    var sampleData: Data {
        switch self {
        case let .login(username, password):
            if username == "john.doe" && password == "password123" {
                let successResponse = """
                    {
                        "status": "success",
                        "token": "abcdef123456",
                        "user": {
                            "id": 1,
                            "name": "John Doe"
                        }
                    }
                    """
                let data = successResponse.data(using: .utf8)!
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let token = json["token"] as? String {
                    SessionManager.shared.accessToken = token
                }
                return data
            } else {
                return stubbedResponse("login_failure")
            }
        case .forgetPassword:
            return stubbedResponse("forget_password_success")
        case .logout:
            return stubbedResponse("logout_success")
        }
    }
}
