//
//  EmployeesView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit
import SnapKit

final class EmployeesView: UIView {
    //MARK: - Properties
    var onEndRefreshing: (()->())?
    
    //MARK: - Views
    let employeesTableView = EmployeesTableView()
    let employeesHeaderView = EmployeesHeaderView()
    
    private lazy var emptyView = EmptyView()
    let errorView = ErrorView()
    
    private let acitvityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        
        return indicator
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        
        refresh.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        refresh.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        return refresh
    }()
    
    //State
    var state: EmployeesState = .error {
        didSet {
            switch state {
            case .loading:
                employeesTableView.backgroundView = acitvityIndicator
            case .loaded(let employees):
                employeesHeaderView.isHidden = false
                employeesTableView.backgroundView = nil
                employeesTableView.update(employees)
            case .noFiltredData:
                employeesTableView.update([])
                employeesTableView.backgroundView = emptyView
            case .error:
                employeesTableView.update([])
                employeesHeaderView.isHidden = true
                employeesTableView.backgroundView = errorView
            }
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        
        updateDepartments()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public updates
    func updateEmployees(_ employees: [Employee]) {
        if employees.isEmpty {
            state = .noFiltredData
        } else {
            state = .loaded(employees)
        }
    }
    
    func updateDepartments() {
        employeesHeaderView.update(Department.allCases)
    }
    
    //MARK: - Actions
    @objc private func handleRefreshControl() {
        self.onEndRefreshing?()
        refreshControl.endRefreshing()
    }
}

//MARK: - SetupViews
private extension EmployeesView {
    func setupViews() {
        self.backgroundColor = .white
        
        [employeesTableView, employeesHeaderView].forEach { self.addSubview($0) }
        employeesTableView.addSubview(refreshControl)
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
