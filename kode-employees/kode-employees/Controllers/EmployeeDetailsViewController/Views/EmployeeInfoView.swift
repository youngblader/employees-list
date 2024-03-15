//
//  EmployeeInfoView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 7.03.24.
//

import UIKit
import SnapKit

final class EmployeeInfoView: UIView {
    //MARK: - Properties
    
    //MARK: - Views
    private let titleLabel = TextLabel(fontLabel: .medium)
    
    private let accessoryLabel: TextLabel = {
        let label =  TextLabel(color: .textGray, fontLabel: .medium)
        
        label.isHidden = true
        
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        image.widthAnchor.constraint(equalToConstant: 21).isActive = true
        image.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        return image
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ icon: String, _ title: String, _ accessory: String? = nil) {
        iconImageView.image = UIImage(named: icon)
        titleLabel.text = title
        
        if let accessory {
            accessoryLabel.isHidden = false
            accessoryLabel.text = accessory
        }
    }
}

private extension EmployeeInfoView {
    func setupViews() {
        [iconImageView, titleLabel, accessoryLabel].forEach({ self.addSubview($0) })
    }
    
    func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.centerY.equalTo(self)
        }
        
        accessoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(self)
        }
    }
}
