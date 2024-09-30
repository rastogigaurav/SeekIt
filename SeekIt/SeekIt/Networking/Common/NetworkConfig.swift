//
//  NetworkConfig.swift
//  SeekIt
//
//  Created by g.b.rastogi on 30/09/24.
//

import Foundation

public enum ConfigKeys: String {
    case appEnv = "AppEnvironment"
    case baseUrl = "BaseURL"
    case appName = "CFBundleName"
}

public class NetworkConfig {

    public init() { }

    public static var shared: NetworkConfig {
        return NetworkConfig()
    }
    /// This method allow to read `Bundle`
    /// Read configuration for `.xconfig`
    /// whenever variable defines in `.xconfig`
    /// it can be read using this function
    /// and don't forget to defined variable into `.plist`
    public func infoForKey(_ key: String, defaultValue: String = "") -> String {
        let dictionary = Bundle.main.infoDictionary?["Config"] as? NSDictionary
        if let value = (dictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: "") {
            return value
        } else {
            return defaultValue
        }
    }
}
