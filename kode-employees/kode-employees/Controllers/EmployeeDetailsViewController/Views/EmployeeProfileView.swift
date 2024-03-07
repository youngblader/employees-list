//
//  EmployeeProfileView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 6.03.24.
//

import UIKit
import SnapKit

final class EmployeeProfileView: UIView {
    private let nameLabel = TextLabel(size: 24, fontLabel: .bold)
    private let tagLabel = TextLabel(size: 17, color: .textGray, fontLabel: .regular)
    private let departmentLabel = TextLabel(size: 13, color: .darkGray, fontLabel: .regular)
    
    private let profileHeaderStackView = UIView()
    
    private let avatarImageView: UIImageView = {
       let image = UIImageView()
        
        image.layer.cornerRadius = 52
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        image.widthAnchor.constraint(equalToConstant: 104).isActive = true
        image.heightAnchor.constraint(equalToConstant: 104).isActive = true
        
        return image
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
        nameLabel.text = employee.getEmployeeFullName()
        tagLabel.text = employee.userTag.lowercased()
        departmentLabel.text = employee.department.title
        
        avatarImageView.sd_setImage(with: URL(string: employee.avatarUrl), placeholderImage: UIImage(named: "plug.png"))
    }
}

extension EmployeeProfileView {
    func setupViews() {
        self.addSubview(avatarImageView)
        self.addSubview(profileHeaderStackView)

        profileHeaderStackView.addSubview(nameLabel)
        profileHeaderStackView.addSubview(tagLabel)
        
        self.addSubview(departmentLabel)
    }
    
    func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(self)
        }
        
        profileHeaderStackView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(profileHeaderStackView)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(profileHeaderStackView)
            make.left.equalTo(nameLabel.snp.right).offset(5)
        }
        
        departmentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderStackView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
    }
}
