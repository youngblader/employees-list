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
    
    var router: Router
    var screenFactory: ScreenFactory
    
    init() {
        router = RouterImpl()
        screenFactory = ScreenFactoryImpl()
        
        screenFactory.di = self
        router.di = self
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
