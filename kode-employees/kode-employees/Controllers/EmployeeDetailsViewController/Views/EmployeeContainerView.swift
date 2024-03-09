//
//  EmployeeContainerView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 6.03.24.
//

import UIKit
import SnapKit

final class EmployeeContainerView: UIView {
    private let employeeInfoBirthdayView = EmployeeInfoView()
    private let employeeInfoPhoneView = EmployeeInfoView()
    
    var onPhoneViewTapped: (()->())?
    
    private let separatorView: UIView = {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = .backgroundLightGray
        
        return view
    }()
    
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
        employeeInfoBirthdayView.update("star", employee.birthday, employee.birthday)
        employeeInfoPhoneView.update("phone", employee.phone ?? "N/A")
    }
    
    //MARK: Actions
    @objc private func didViewTapped() {
        self.onPhoneViewTapped?()
    }
}

extension EmployeeContainerView {
    func setupViews() {
        self.backgroundColor = .white

        self.addSubview(employeeInfoBirthdayView)
        self.addSubview(separatorView)
        self.addSubview(employeeInfoPhoneView)
        
        employeeInfoPhoneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didViewTapped)))
    }
    
    func setupConstraints() {
        employeeInfoBirthdayView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.right.equalTo(self).inset(16)
            make.height.equalTo(60)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(employeeInfoBirthdayView.snp.bottom)
            make.left.right.equalTo(self).inset(16)
        }
        
        employeeInfoPhoneView.snp.makeConstraints { make in
            make.top.equalTo(employeeInfoBirthdayView.snp.bottom)
            make.left.right.equalTo(self).inset(16)
            make.height.equalTo(60)
        }
    }
}
