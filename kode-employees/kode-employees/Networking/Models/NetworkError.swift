//
//  NetworkError.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import Foundation

enum NetworkError: Error {
    case urlInvalid
    case requestInvalid
    case decode(error: String)
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var message: String {
        switch self {
        case .urlInvalid:
            return "URL invalid"
        case .requestInvalid:
            return "Request invalid"
        case .decode(let error):
            return "!!!!ERROR, KEY NOT FOUND: \(error)"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
