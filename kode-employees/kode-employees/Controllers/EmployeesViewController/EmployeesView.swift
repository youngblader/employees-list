//
//  EmployeesView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit
import SnapKit

final class EmployeesView: UIView {
    //MARK: - Views
    private var refreshControl = UIRefreshControl()
    
    let employeesTableView = EmployeesTableView()
    let employeesHeaderView = EmployeesHeaderView()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStyleView()
        setupViews()
        setupConstraints()
        
        updateDepartments()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public updates
    func updateEmployees(_ employees: [Employee]) {
        employeesTableView.update(employees)
    }
    
    func updateDepartments() {
        employeesHeaderView.update(Department.allCases)
    }
    
    //MARK: - Actions
    @objc private func handleRefresh() {
//        refreshControl.endRefreshing()
    }
}

//MARK: - SetupViews
private extension EmployeesView {
    func setupStyleView() {
        self.backgroundColor = .white
        
//        self.refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    func setupViews() {
        self.addSubview(employeesTableView)
        self.addSubview(employeesHeaderView)
        
//        employeesTableView.addSubview(refreshControl)
    }
    
    func setupConstraints() {
        employeesHeaderView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(6)
            make.left.right.equalTo(self)
        }
        
        employeesTableView.snp.makeConstraints { make in
            make.top.equalTo(employeesHeaderView.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
    }
}
