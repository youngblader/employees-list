//
//  EmloyeesResponse.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import Foundation

// MARK: - EmployeesResponse
struct EmployeesResponse: Codable {
    let items: [Employee]
}
