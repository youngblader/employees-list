//
//  Di.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit

final class Di {
    static let shared = Di()
    
    //MARK: Services
    var employeesService: EmployeesService
    var callService: CallService
    
    var router: Router
    var screenFactory: ScreenFactory
    
    init() {
        employeesService = EmployeesServiceImpl()
        callService = CallServiceImpl()

        router = RouterImpl()
        screenFactory = ScreenFactoryImpl()
        
        screenFactory.di = self
        router.di = self
    }
    
    //MARK: - Providers
    var employeesProvider: EmployeesProviderImpl {
        return EmployeesProviderImpl(employeesService: employeesService, router: router)
    }
    
    var employeeDetailsProvider: EmployeeDetailsProviderImpl {
        return EmployeeDetailsProviderImpl(callService: callService, router: router)
    }
}

extension Di {
    func makeWindowWithController(scene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: scene)
        
        let rootViewController = screenFactory.createEmployeesController()
        window.rootViewController = rootViewController
        
        return window
    }
}
