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
    func createDetailsEmployeeController() -> DetailsEmployeeViewController
}

final class ScreenFactoryImpl: ScreenFactory {
    weak var di: Di!
    
    func createEmployeesController() -> UINavigationController {
        let controller = EmployeesViewController()

        return UINavigationController(rootViewController: controller)
    }
    
    func createDetailsEmployeeController() -> DetailsEmployeeViewController {
        let controller = DetailsEmployeeViewController()
        
        return controller
    }
}
