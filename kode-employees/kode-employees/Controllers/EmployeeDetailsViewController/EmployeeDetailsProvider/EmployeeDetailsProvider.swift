//
//  EmployeeDetailsProvider.swift
//  kode-employees
//
//  Created by Евгений Зорич on 7.03.24.
//

import Foundation

protocol EmployeeDetailsProvider {
    var callService: CallService { get set }
    var router: Router { get }
}

final class EmployeeDetailsProviderImpl: EmployeeDetailsProvider {
    var callService: CallService
    var router: Router
    
    init(callService: CallService, router: Router) {
        self.callService = callService
        self.router = router
    }
}
