//
//  EndPoint.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: NetworkMethod { get }
    var parameters: [URLQueryItem] { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "stoplight.io"
    }
}
