//
//  EmployeesViewController.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit

final class EmployeesViewController: UIViewController, SortDelegate {
    private let provider: EmployeesProvider
    
    private var employees: [Employee] = []
    private var filtredEmployees: [Employee] = []
    private var selectedSortType: SortType = .alphabet
    private var selectedDepartment: Department = .all
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentSortEmployeesController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEmployees()
        
        employeesView.employeesTableView.onCellTapped = { employee in
            self.presentEmployeeDetailsController(employee)
        }
        
        employeesView.employeesHeaderView.departmentsCollectionView.onCellTapped = { department in
            self.selectedDepartment = department
            self.filteringEmployees(department)
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
    
    //MARK: - Private
    private func fetchEmployees() {
        Task {
            do {
                let employees = try await provider.employeesService.fetchEmployees()
                
                self.employees = employees
                self.filtredEmployees = employees
                
                self.update()
            } catch {
                print("ERROR", error.localizedDescription)
            }
        }
    }
    
    private func update() {
        self.sortingAlpabetEmployees()
        self.updateEmployees(filtredEmployees)
    }
    
    //MARK: Sort
    private func sortingAlpabetEmployees() {
        filtredEmployees.sort { $0.firstName < $1.firstName }
    }
    
    private func sortingBirthdayEmployees() {
        filtredEmployees.sort { $0.birthday < $1.birthday }
    }

    // MARK: - Public Sort Delegate
    func sortTypeChanged(_ sortType: SortType) {
        self.selectedSortType = sortType
        self.filteringEmployees(selectedDepartment)
    }
    
    private func updateEmployees(_ employees: [Employee]) {
        employeesView.updateEmployees(employees)
    }
    
    private func applyEmployeeSorting() {
        switch selectedSortType {
        case .alphabet:
            sortingAlpabetEmployees()
        case .birthday:
            sortingBirthdayEmployees()
        }
    }
    
    private func filteringEmployees(_ department: Department) {
        if department == .all {
            filtredEmployees = employees
        } else {
            filtredEmployees = employees.filter({ $0.department.title == department.title })
        }
        
        self.applyEmployeeSorting()
        self.updateEmployees(filtredEmployees)
    }
    
    private func presentSortEmployeesController() {
        let controller = EmployeesSortViewController(sortType: selectedSortType)
        controller.sortDelegate = self
        
        let vc = UINavigationController(rootViewController: controller)
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        
        navigationController?.present(vc, animated: true)
    }
    
    private func presentEmployeeDetailsController(_ employee: Employee) {
        provider.router.navigateToEmployeeDetailsController(employee, self)
    }
}
