//
//  UserService.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Moya
import Foundation

enum UserService {
    case fetchUserProfile
    case fetchPosts
    // Add more cases as needed
}

extension UserService: LocalizableTargetType {
    var isLocalEnvironment: Bool {
        return Application.isLocalEnvironment
    }
    
    var localResponseFileName: String? {
        switch self {
        case .fetchUserProfile:
            return "login_success" // or "login_failure" based on the scenario
        case .fetchPosts:
            return "logout_response"
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://api.example.com")!  // Change to your base URL
    }
    
    var path: String {
        switch self {
        case .fetchUserProfile:
            return "/user/profile"
        case .fetchPosts:
            return "/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUserProfile, .fetchPosts:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchUserProfile, .fetchPosts:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var sampleData: Data {
        switch self {
        case .fetchUserProfile:
            return Data() // Replace with sample JSON data if needed
        case .fetchPosts:
            return Data() // Replace with sample JSON data if needed
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

