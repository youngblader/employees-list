//
//  EmployeesViewController.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit

final class EmployeesViewController: UIViewController {
    private let provider: EmployeesProvider
    private var employees: [Employee] = []
    
    // MARK: - LoadView
    private var employeesView: EmployeesView {
        return self.view as! EmployeesView
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = EmployeesView(frame: UIScreen.main.bounds)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEmployees()
        
        employeesView.employeesTableView.onCellTapped = { employee in
            self.presentDetailsEmployeeController(employee)
        }
        
        employeesView.employeesHeaderView.departmentsCollectionView.onCellTapped = { department in
            self.filtredEmployees(department)
        }
    }
    
    //MARK: - Init
    init(employeeProvider: EmployeesProvider) {
        self.provider = employeeProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchEmployees() {
        Task {
            do {
                let employees = try await  provider.employeesService.fetchEmployees()
                
                self.employees = employees
                employeesView.updateEmployees(employees)
            } catch {
                print("ERROR", error)
            }
        }
    }
    
    private func filtredEmployees(_ department: Department) {
        if department == .all {
            employeesView.updateEmployees(employees)
            return
        }
        
        let filtredEmployees = employees.filter({ $0.department.title == department.title })
        
        employeesView.updateEmployees(filtredEmployees)
    }
    
    private func presentDetailsEmployeeController(_ employee: Employee) {
        provider.router.navigateToDetailsEmpolyeeController(employee, self)
    }
}
