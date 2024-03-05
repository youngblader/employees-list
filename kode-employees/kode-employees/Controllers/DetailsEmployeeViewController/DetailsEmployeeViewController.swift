//
//  DetailsEmployeeViewController.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit

final class DetailsEmployeeViewController: UIViewController {
    private let employee: Employee

    //MARK: - Views
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Init
    init(employee: Employee) {
        self.employee = employee
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
