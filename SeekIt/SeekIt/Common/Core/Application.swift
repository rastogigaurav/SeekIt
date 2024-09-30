//
//  Application.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Foundation

struct Application {
    enum AppEnvironment: String {
        case debugLocal = "Debug-Local"
        case releaseLocal = "Release-Local"
        case debugProduction = "Debug-Prod"
        case releaseProduction = "Release-Prod"
    }

    struct Constants {
        static let bundleShortVersionString = "CFBundleShortVersionString"
        static let bundleVersionString = "CFBundleVersion"
        static let config = "Config"
        static let appEnvironment = "AppEnvironment"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dictionary
    }()
    
    // App Version
    static var appVersion: String {
        guard let version = Application.infoDictionary[Constants.bundleShortVersionString] as? String else {
            return "1.0.0"
        }
        return version
    }
    
    // App Build Number
    static var buildNumber: String {
        guard let buildNumber = Application.infoDictionary[Constants.bundleVersionString] as? String else {
            return "1"
        }
        return buildNumber
    }
    
    private static let configDictionary: [String: Any] = {
        guard let config = Application.infoDictionary[Constants.config] as? [String: Any] else {
            return [:]
        }
        return config
    }()
    
    static let appEnvironment: String = {
       guard let environment = Application.configDictionary[Constants.appEnvironment] as? String else {
           return ""
       }
       return environment
   }()
    
    // Environment (local, prod)
    static var environment: AppEnvironment {
        guard let environment = Application.configDictionary[Constants.appEnvironment] as? String else {
            return .debugLocal
        }
        print("GR: Environment \(Application.AppEnvironment(rawValue: environment)?.rawValue ?? AppEnvironment.debugLocal.rawValue)")
        return Application.AppEnvironment(rawValue: environment) ?? .debugLocal
    }
    
    // Local or Remote API
    static var isLocalEnvironment: Bool {
        print("GR: isLocalEnvironment \(environment == .debugLocal || environment == .releaseLocal)")
        return environment == .debugLocal || environment == .releaseLocal
    }
}
