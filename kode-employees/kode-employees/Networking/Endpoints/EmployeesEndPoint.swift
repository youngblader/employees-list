//
//  EmployeesEndPoint.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import Foundation

enum EmployeesEndPoint {
    case getEmpoloyees
}

extension EmployeesEndPoint: Endpoint {
    var method: NetworkMethod {
        switch self {
        case .getEmpoloyees:
            return .get
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .getEmpoloyees:
            return nil
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getEmpoloyees:
            return []
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getEmpoloyees:
            return [
                "Accept": "application/json, application/xml",
                "Prefer": "code=200, dynamic=true"
            ]
        }
    }
    
    var path: String {
        switch self {
        case .getEmpoloyees:
            return "/mocks/kode-education/trainee-test/25143926/users"
        }
    }
}
