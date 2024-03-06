//
//  Router.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit

protocol Router {
    var di: Di! { get set }
    
    func navigateToDetailsEmpolyeeController(_ employee: Employee, _ from: UIViewController)
}

final class RouterImpl: Router {
    weak var di: Di!
    
    func navigateToDetailsEmpolyeeController(_ employee: Employee, _ from: UIViewController) {
        let controller = di.screenFactory.createDetailsEmployeeController(employee)
        
        from.navigationController?.pushViewController(controller, animated: true)
    }
}
