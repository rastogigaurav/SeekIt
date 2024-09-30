//
//  SessionManager.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    
    private init() {}

    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "accessToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "accessToken")
        }
    }
    
    func clearSession() {
        accessToken = nil
    }
}
