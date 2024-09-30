//
//  NetworkError.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Foundation

enum NetworkError: Error {
    /// Unknown or not supported error.
    case unknown

    /// Not connected to the internet.
    case notConnectedToInternet

    /// International data roaming turned off.
    case internationalRoamingOff

    /// Cannot reach the server.
    case notReachedServer

    /// Connection is lost.
    case connectionLost

    /// Incorrect data returned from the server.
    case incorrectDataReturned

    /// Connection is insecure
    case insecureConnection

    case cancelled

    /// Connected to Gateway, but dont have response from BE
    case serviceUnavailable

    /// empty response {}
    case emptyResponse

    case softError(error: ErrorResponse?, statusCode: Int?)
        
    /// Conflict
    case conflictError(error: Data)
        
    /// Request Timeout
    case requestTimeout

    public var message: String {
        switch self {
        case .incorrectDataReturned:
            return "Incorrect JSON format"
        case .softError(let error, _):
            return error?.message ?? "Something went wrong"
        case .notConnectedToInternet:
            return "You are offline"
        case .notReachedServer:
            return "Server not found"
        case .connectionLost:
            return "Connection lost"
        case .insecureConnection:
            return "Insecure connection"
        case .cancelled:
            return "Request Cancelled"
        case .serviceUnavailable:
            return "Service Unavailable"
        case .emptyResponse:
            return "Empty Response"
        default:
            return "Unknown error"
        }
    }

    public var softErrorResponse: ErrorResponse? {
        switch self {
        case .softError(let errorResponse, _):
            return errorResponse
        default:
            return nil
        }
    }
    
    public var softErrorResponseStatusCode: Int? {
        switch self {
        case .softError(_, let statusCode):
            return statusCode
        default:
            return nil
        }
    }
        
    public var isUnknownError: Bool {
        switch self {
        case .unknown, .serviceUnavailable:
            return true
        default:
            return false
        }
    }
    
    public var isRequestTimeoutError: Bool {
        switch self {
        case .requestTimeout:
            return true
        default:
            return false
        }
    }

    public init(error: NSError) {
        switch error.domain {
        case NSURLErrorDomain:
            switch error.code {
            case NSURLErrorCancelled:
                self = .cancelled
            case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost, NSURLErrorDNSLookupFailed:
                self = .notReachedServer
            case NSURLErrorNetworkConnectionLost:
                self = .connectionLost
            case NSURLErrorNotConnectedToInternet:
                self = .notConnectedToInternet
            case NSURLErrorRedirectToNonExistentLocation, NSURLErrorBadServerResponse, NSURLErrorZeroByteResource, NSURLErrorCannotDecodeRawData, NSURLErrorCannotDecodeContentData,
                 NSURLErrorCannotParseResponse, NSURLErrorBadURL, NSURLErrorFileDoesNotExist, NSURLErrorFileIsDirectory, NSURLErrorResourceUnavailable,
                 NSURLErrorDataLengthExceedsMaximum, NSURLErrorUnsupportedURL:
                self = .incorrectDataReturned
            case NSURLErrorInternationalRoamingOff:
                self = .internationalRoamingOff
            case NSURLErrorTimedOut:
                self = .requestTimeout
            default:
                self = .unknown
            }
        case String(kCFErrorDomainCFNetwork):
            switch error.code {
            case
            Int(CFNetworkErrors.cfurlErrorServerCertificateNotYetValid.rawValue),
            Int(CFNetworkErrors.cfurlErrorServerCertificateUntrusted.rawValue),
            Int(CFNetworkErrors.cfurlErrorServerCertificateHasBadDate.rawValue),
            Int(CFNetworkErrors.cfurlErrorServerCertificateHasUnknownRoot.rawValue),
            Int(CFNetworkErrors.cfurlErrorClientCertificateRejected.rawValue),
            Int(CFNetworkErrors.cfurlErrorClientCertificateRequired.rawValue),
            Int(CFNetworkErrors.cfErrorHTTPSProxyConnectionFailure.rawValue),
            Int(CFNetworkErrors.cfurlErrorSecureConnectionFailed.rawValue),
            Int(CFNetworkErrors.cfurlErrorCannotLoadFromNetwork.rawValue),
            Int(CFNetworkErrors.cfurlErrorCancelled.rawValue):
                self = .insecureConnection
            case Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue):
                self = .notConnectedToInternet
            case Int(CFNetworkErrors.cfurlErrorTimedOut.rawValue):
                self = .requestTimeout
            default:
                self = .unknown
            }
        default:
            self = .unknown
        }
    }

    public func errorResponse() -> ErrorResponse {
        switch self {
        case .softError(let errorResponse, _):
            return errorResponse ?? .genericError()
        case .serviceUnavailable:
            return .serverConnectionError()
        case .conflictError(let data):
            guard let result = try? JSONDecoder().decode(ErrorResponse.self, from: data)
            else { return .genericError()}
            return result
        default:
            return .genericError()
        }
    }
}
