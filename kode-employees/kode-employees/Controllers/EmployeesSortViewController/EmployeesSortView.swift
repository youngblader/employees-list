//
//  EmployeesSortView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 8.03.24.
//

import UIKit
import SnapKit

final class EmployeesSortView: UIView {
    //MARK: - Properties
    private var selectedSortType: SortType
    
    var onAlphabetButtonTapped: (()->())?
    var onBirthdayButtonTapped: (()->())?
    
    //MARK: - Views
    private lazy var alphabetView: RadioButtonView = {
        let view = RadioButtonView()
        
        view.button.isSelected = selectedSortType == .alphabet
        view.button.addTarget(self, action: #selector(didAlphabetButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var birthdayView: RadioButtonView = {
        let view = RadioButtonView(title: "По дню рождения")
        
        view.button.isSelected = selectedSortType == .birthday
        view.button.addTarget(self, action: #selector(didBirthdayButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    //MARK: - Init
    init(sortType: SortType) {
        self.selectedSortType = sortType
        super.init(frame: .zero)
        
        setupStyleSubviews()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func didAlphabetButtonTapped(_ sender: UIButton) {
        onAlphabetButtonTapped?()
        
        alphabetView.button.isSelected = true
        birthdayView.button.isSelected = false
    }
    
    @objc func didBirthdayButtonTapped(_ sender: UIButton) {
        onBirthdayButtonTapped?()
        
        alphabetView.button.isSelected = false
        birthdayView.button.isSelected = true
    }
}

extension EmployeesSortView {
    func setupStyleSubviews() {
        self.backgroundColor = .white
    }
    
    func setupViews() {
        [alphabetView, birthdayView].forEach({ self.addSubview($0) })
    }
    
    func setupConstraints() {
        alphabetView.snp.makeConstraints { make in
            make.top.equalTo(self).inset(68)
            make.left.right.equalTo(24)
            make.height.equalTo(60)
        }
        
        birthdayView.snp.makeConstraints { make in
            make.top.equalTo(alphabetView.snp.bottom)
            make.left.right.equalTo(24)
            make.height.equalTo(60)
        }
    }
}
