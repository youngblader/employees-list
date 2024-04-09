//
//  EmployeesViewController.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit

//State Pattern
enum EmployeesState {
    case loading
    case loaded([Employee])
    case noFiltredData
    case error
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEmployees()
        
        employeesView.employeesTableView.onCellTapped = { [weak self] employee in
            self?.presentEmployeeDetailsController(employee)
        }
        
        employeesView.employeesHeaderView.departmentsCollectionView.onCellTapped = { [weak self] department in
            self?.selectedDepartment = department
            self?.filteringEmployees(department)
        }
        
        employeesView.onEndRefreshing = { [weak self] in
            self?.fetchEmployees(true)
        }
        
        employeesView.errorView.onRetryRequest = { [weak self] in
            self?.fetchEmployees()
        }
        
        employeesView.employeesHeaderView.searchBar.onFilterButtonTapped = { [weak self] in
            self?.presentSortEmployeesController()
        }
        
        employeesView.employeesHeaderView.searchBar.onSearchTextChanged = { [weak self] text in
            self?.searchEmployees(text)
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
    private func fetchEmployees(_ isRefresh: Bool = false) {
        Task {
            if !isRefresh {
                employeesView.state = .loading
            }
            
            do {
                let employees = try await provider.employeesService.fetchEmployees()
                
                self.employees = employees
                self.filtredEmployees = employees
                
                self.filteringEmployees(selectedDepartment)
            } catch {
                employeesView.state = .error
                print("ERROR", error.localizedDescription)
            }
        }
    }
    
    //MARK: Search
    private func searchEmployees(_ searchText: String) {
        let searchedEmployees = self.filtredEmployees.filter({ employee in
            return employee.firstName.lowercased().prefix(searchText.count) == searchText.lowercased() ||
            employee.lastName.lowercased().prefix(searchText.count) == searchText.lowercased() ||
            employee.userTag.lowercased().prefix(searchText.count) == searchText.lowercased()
        })
        
        if searchedEmployees.isEmpty && !searchText.isEmpty {
            employeesView.state = .noFiltredData
        } else {
            self.updateEmployees(searchedEmployees.isEmpty ? filtredEmployees : searchedEmployees)
        }
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
