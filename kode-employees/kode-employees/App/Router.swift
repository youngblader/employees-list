//
//  Router.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit

protocol Router {
    var di: Di! { get set }
    
    func navigateToEmployeeDetailsController(_ employee: Employee, _ from: UIViewController)
}

final class RouterImpl: Router {
    weak var di: Di!
    
    func navigateToEmployeeDetailsController(_ employee: Employee, _ from: UIViewController) {
        let controller = di.screenFactory.createEmployeeDetailsController(employee)
        
        from.navigationController?.pushViewController(controller, animated: true)
    }
}
