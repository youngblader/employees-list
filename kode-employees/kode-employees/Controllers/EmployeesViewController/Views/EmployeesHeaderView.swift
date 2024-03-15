//
//  EmployeesHeaderView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit
import SnapKit

final class EmployeesHeaderView: UIView {
    //MARK: - Views
    var searchBar = SearchBar()
    var departmentsCollectionView = DepartmentsCollectionView()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = .placeholderGray.withAlphaComponent(0.6)
        
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
    func update(_ departments: [Department]) {
        departmentsCollectionView.update(departments)
    }
}

extension EmployeesHeaderView {
    func setupViews() {
        [departmentsCollectionView, searchBar, separatorView].forEach({ self.addSubview($0 )})
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(self).inset(16)
            make.height.equalTo(40)
        }
        
        departmentsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(6)
            make.left.right.equalTo(self)
            make.bottom.equalTo(separatorView.snp.top)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(departmentsCollectionView.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
    }
}
