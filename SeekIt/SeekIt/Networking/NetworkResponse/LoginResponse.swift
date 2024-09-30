//
//  LoginResponse.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Foundation

struct LoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let user: User
}

struct User: Codable {
    let id: Int
    let name: String
    let email: String
}
