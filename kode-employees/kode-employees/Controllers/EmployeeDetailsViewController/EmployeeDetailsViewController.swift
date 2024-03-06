//
//  EmployeeDetailsViewController.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit

final class EmployeeDetailsViewController: UIViewController {
    private let employee: Employee

    //MARK: - Views
    
    // MARK: - LoadView
    private var employeeDetailsView: EmployeeDetailsView {
        return self.view as! EmployeeDetailsView
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = EmployeeDetailsView(frame: UIScreen.main.bounds)
    }
    
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
