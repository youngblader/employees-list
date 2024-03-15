//
//  EmployeeContainerView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 6.03.24.
//

import UIKit
import SnapKit

final class EmployeeContainerView: UIView {
    //MARK: - Properties
    var onPhoneViewTapped: (()->())?
    
    //MARK: - Views
    private let employeeInfoBirthdayView = EmployeeInfoView()
    private lazy var employeeInfoPhoneView: EmployeeInfoView = {
        let view = EmployeeInfoView()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPhoneViewTapped)))
        
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = UIColor.placeholderGray
        
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
    @objc private func didPhoneViewTapped() {
        self.onPhoneViewTapped?()
    }
}

extension EmployeeContainerView {
    func setupStyleSubviews() {
        self.backgroundColor = .white
    }
    
    func setupViews() {
        [employeeInfoBirthdayView, separatorView, employeeInfoPhoneView].forEach({ self.addSubview($0) })
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
