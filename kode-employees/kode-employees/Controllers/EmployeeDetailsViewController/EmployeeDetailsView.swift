//
//  EmployeeDetailsView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 6.03.24.
//

import UIKit
import SnapKit

final class EmployeeDetailsView: UIView {
    //MARK: - Views
    private let employeeProfileView = EmployeeProfileView()
    let employeeContainerView = EmployeeContainerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ employee: Employee) {
        employeeProfileView.update(employee)
        employeeContainerView.update(employee)
    }
}

private extension EmployeeDetailsView {
    func setupViews() {
        self.backgroundColor = .backgroundLightGray
        
        self.addSubview(employeeProfileView)
        self.addSubview(employeeContainerView)
    }
    
    func setupConstraints() {
        employeeProfileView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(self)
            make.height.equalTo(184)
        }
        
        employeeContainerView.snp.makeConstraints { make in
            make.top.equalTo(employeeProfileView.snp.bottom).offset(24)
            make.left.right.bottom.equalTo(self)
        }
    }
}
