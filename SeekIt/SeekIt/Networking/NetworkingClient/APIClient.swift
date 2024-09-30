//
//  APIClient.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//
import Moya
import Foundation
import Alamofire

enum APIError: Error {
    case networkError(Error)
    case decodingError(Error)
    case invalidResponse
}

enum HTTPStatusCode: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case conflict = 409
    case internalServerError = 500
    case serviceUnavailable
}

protocol LocalizableTargetType: TargetType {
    var isLocalEnvironment: Bool { get }
    var localResponseFileName: String? { get }
}

extension LocalizableTargetType {
    var isLocalEnvironment: Bool {
        return Application.isLocalEnvironment // Check your application environment
    }
}

class APIClient {
    fileprivate let provider: MoyaProvider<MultiTarget>
    static var shared = APIClient()
    init(provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>()) {
        self.provider = provider
    }
    
    public func requestObject<T: LocalizableTargetType, C: Decodable>(_ target: T, c classType: C.Type, completion: @escaping (Result<C, NetworkError>) -> Void) {
        if target.isLocalEnvironment, let localFileName = target.localResponseFileName {
            loadLocalJson(filename: localFileName) { result in
                completion(result)
            }
        } else {
            URLCache.shared.removeAllCachedResponses()
            provider.request(MultiTarget(target)) { [weak self](responseResult) in
                self?.handleMoyaResult(result: responseResult, completion: completion)
            }
        }
    }
    
    func handleMoyaResult<T: Decodable>(result: Result<Moya.Response, MoyaError>,
                                        completion: @escaping (Result<T, NetworkError>) -> Void) {
        switch result {
        case .success(let value):
            do {
                let filteredResponse = try value.filterSuccessfulStatusCodes()
                let result = try filteredResponse.map(T.self)
                completion(.success(result))
            } catch is DecodingError {
                completion(.failure(NetworkError.incorrectDataReturned))
            } catch MoyaError.statusCode(let response) {
                let error = moyaError(response: response, value: value)
                completion(.failure(error))
            } catch(let error) {
                print(error)
                if (try? value.map(EmptyResponse.self)) != nil {
                    completion(.failure(NetworkError.emptyResponse))
                } else {
                    completion(.failure(NetworkError.unknown))
                }
            }
        case .failure(let error):
            let error = handleFailure(error: error)
            completion(.failure(error))
        }
    }
    
    private func handleFailure(error: MoyaError) -> NetworkError {
        switch error {
        case .underlying(let error, _):
            if let underlyingError = error.asAFError?.underlyingError {
                return NetworkError(error: underlyingError as NSError)
            } else {
                return NetworkError(error: error as NSError)
            }
        default:
            do {
                let result = try error.response?.map(ErrorResponse.self)
                let softError = NetworkError.softError(error: result, statusCode: error.errorCode )

                return softError
            } catch {
                return NetworkError.incorrectDataReturned
            }
        }
    }
    
    private func moyaError(response: Moya.Response, value: Moya.Response) -> NetworkError {
        if response.statusCode == HTTPStatusCode.serviceUnavailable.rawValue {
            do {
                let result = try value.map(ErrorResponse.self)
                if result.title != "", result.message != "" {
                    return NetworkError.softError(error: result, statusCode: response.statusCode)
                } else {
                    return NetworkError.serviceUnavailable
                }
            } catch {
                return NetworkError.serviceUnavailable
            }
        } else if response.statusCode == HTTPStatusCode.conflict.rawValue {
            return .conflictError(error: value.data)
        } else {
            return .incorrectDataReturned
        }
    }
}

extension APIClient {
    private func loadLocalJson<T: Decodable>(
        filename: String,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            completion(.failure(NetworkError.unknown))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let model = try JSONDecoder().decode(T.self, from: data)
            completion(.success(model))
        } catch {
            completion(.failure(NetworkError.unknown))
        }
    }
    
    func stubbedResponse(_ filename: String) -> Data {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
            return Data()
        }
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        return data ?? Data()
    }
}
