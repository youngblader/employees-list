//
//  EmployeesProviderImpl.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import Foundation

protocol EmployeesProvider {
    var router: Router { get }
    var employeesService: EmployeesService { get set }
}

final class EmployeesProviderImpl: EmployeesProvider {
    var employeesService: EmployeesService
    var router: Router
    
    init(employeesService: EmployeesService, router: Router) {
        self.employeesService = employeesService
        self.router = router
    }
}
