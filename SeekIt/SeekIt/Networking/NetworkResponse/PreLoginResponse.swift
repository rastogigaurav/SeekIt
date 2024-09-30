//
//  PreLoginResponse.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Foundation

struct PreLoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
