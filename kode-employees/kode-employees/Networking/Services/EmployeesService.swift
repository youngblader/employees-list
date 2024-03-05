//
//  EmployeesService.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import Foundation

protocol EmployeesService {
    func fetchEmployees() async throws -> [Employee]
}

final class EmployeesServiceImpl: API, EmployeesService {
    func fetchEmployees() async throws -> [Employee] {
        return try await request(endpoint: EmployeesEndPoint.getEmpoloyees, responseModel: EmployeesResponse.self).items
    }
}
