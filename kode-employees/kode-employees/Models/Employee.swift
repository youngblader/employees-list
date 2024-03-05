//
//  Employees.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import Foundation

// MARK: - Employee
struct Employee: Codable {
    let id: String
    let avatarUrl: String
    let firstName, lastName, userTag, department: String
    let position, birthday, phone: String
    
    func getEmployeeFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}
