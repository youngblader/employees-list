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
    let firstName, lastName, userTag: String
    let position, birthday, phone: String
    let department: Department
    
    func getEmployeeFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}

enum Department: String, CodingKey, Codable, CaseIterable {
    case all
    case android
    case iOS = "ios"
    case design
    case management
    case qa
    case backOffice = "back_office"
    case frontend
    case hr
    case pr
    case backend
    case support
    case analytics

    var title: String {
        switch self {
        case .all:
            return "Все"
        case .android:
            return "Android"
        case .iOS:
            return "iOS"
        case .design:
            return "Design"
        case .management:
            return "Management"
        case .qa:
            return "QA"
        case .backOffice:
            return "BackOffice"
        case .frontend:
            return "Frontend"
        case .hr:
            return "HR"
        case .pr:
            return "PR"
        case .backend:
            return "Backend"
        case .support:
            return "Support"
        case .analytics:
            return "Analytics"
        }
    }
}
