//
//  EmployeeDetailsView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 6.03.24.
//

import UIKit

final class EmployeeDetailsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension EmployeeDetailsView {
    func setupViews() {
        self.backgroundColor = .white
        
    }
    
    func setupConstraints() {
        
    }
}
