//
//  EmloyeesResponse.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import Foundation

// MARK: - EmployeeResponse
struct EmployeeResponse: Codable {
    let employees: [Employee]
}
