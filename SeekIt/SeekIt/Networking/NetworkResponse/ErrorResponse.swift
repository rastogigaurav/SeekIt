//
//  ErrorResponse.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Foundation

enum ErrorResponseCode: String, Decodable {
    case notConnectedToInternet = "00000"
    case serviceDown = "00001"
    case genericError = "00002"
    case serverError = "00003"
    case sessionTimeout = "00004"
    case userAlreadyCreated = "10001"
}

struct ErrorResponse: Codable, Error {
    public let code: String
    public let title: String
    public let message: String
//    public var statusCode: Int

    init(code: String, title: String, message: String) {
        self.code = code
        self.title = title
        self.message = message
//        self.statusCode = statusCode
    }
    
    static func genericError() -> ErrorResponse {
        return ErrorResponse(code: ErrorResponseCode.genericError.rawValue,
                             title: L10n.commonApiClientUnknownErrorTitle,
                             message: L10n.commonApiClientUnknownErrorMessage)
    }

    static func serverConnectionError() -> ErrorResponse {
        return ErrorResponse(code: ErrorResponseCode.serverError.rawValue,
                             title: L10n.commonApiClientUnknownErrorTitle,
                             message: L10n.commonApiClientUnknownErrorMessage)
    }

    static func notConnectedToInternet() -> ErrorResponse {
        return ErrorResponse(code: ErrorResponseCode.notConnectedToInternet.rawValue,
                             title: L10n.commonApiClientNoInternetErrorTitle,
                             message: L10n.commonApiClientNoInternetErrorMessage)
    }
}
