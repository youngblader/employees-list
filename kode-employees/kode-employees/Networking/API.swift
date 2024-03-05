//
//  API.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import Foundation

protocol API {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
}

extension API {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.parameters
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        print("URL", url)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        let session = URLSession(configuration: .default)
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.noResponse
            }
            
            switch response.statusCode {
            case 200..<299:
                do {
                    let decodedResponse = try decoder.decode(responseModel, from: data)
                    
                    return decodedResponse
                } catch DecodingError.keyNotFound(let key, _) {
                    throw NetworkError.decode(error: key.stringValue)
                }
            case 401:
                throw NetworkError.unauthorized
            default:
                throw NetworkError.unexpectedStatusCode
            }
        } catch {
            throw NetworkError.unknown
        }
    }
}
