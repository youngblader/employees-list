//
//  ScreenFactory.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit

protocol ScreenFactory {
    var di: Di! { get set }
    
    func createEmployeesController() -> UINavigationController
    func createEmployeeDetailsController(_ employee: Employee) -> EmployeeDetailsViewController
}

final class ScreenFactoryImpl: ScreenFactory {
    weak var di: Di!
    
    func createEmployeesController() -> UINavigationController {
        let controller = EmployeesViewController(employeeProvider: di.employeesProvider)
        
        return UINavigationController(rootViewController: controller)
    }
    
    func createEmployeeDetailsController(_ employee: Employee) -> EmployeeDetailsViewController {
        let controller = EmployeeDetailsViewController(provider: di.employeeDetailsProvider, employee: employee)
        
        return controller
    }
}
