//
//  CommonHeaders.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Foundation

struct CommonHeaders {
    enum HeaderField: String {
        case authentication = "Authorization"
        case language = "Accept-Language"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case octetStream = "application/octet-stream"
    }
    
    static func defaultHeaders() -> [String: String] {
        var headers: [String: String] = [
            HeaderField.contentType.rawValue : ContentType.json.rawValue
        ]
        
        // Add the Authorization header if the access token is available
        if let token = SessionManager.shared.accessToken {
            headers[HeaderField.authentication.rawValue] = "Bearer \(token)"
        }
        
        return headers
    }
}

