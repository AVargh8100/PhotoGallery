//
//  WebServiceClient.swift
//  PhotoGallery
//
//  Created by Alex Varghese on 14/07/24.
//

import Foundation

enum WebServiceClientError:Error {
    case invalidRequest
    case apiError
    case dataNotFound
    case responseError
    case parsingError
    case invalidResponse
}

protocol WebServiceClientContract {
    func restApi<T: Decodable>(_ request: Requestable, type: T.Type) async throws -> T
}

struct WebServiceClient {
    private let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension WebServiceClient: WebServiceClientContract, JsonDecoder {
    func restApi<T>(_ request: Requestable, type: T.Type) async throws -> T where T : Decodable {
        guard let urlRequest = request.createUrlRequest() else {
            throw WebServiceClientError.invalidRequest
        }
        let (data, response) = try await urlSession.data(for: urlRequest)
        if  response.isValidResponse() {
            return try decode(type:type, data: data)
        } else {
            throw WebServiceClientError.invalidResponse
        }
    }
}

extension URLResponse {
    func isValidResponse()-> Bool {
        guard let response = self as? HTTPURLResponse else {
            return false
        }
        switch response.statusCode {
        case 200...299:
          return true
        default:
          return false
        }
    }
}
