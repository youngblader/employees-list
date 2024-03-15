//
//  EmployeeCell.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit
import SnapKit
import SDWebImage

final class EmployeeCell: UITableViewCell {
    static let reuseId = "EmployeeCell"
    
    private let nameLabel = TextLabel(fontLabel: .medium, linesNumber: 1)
    private let departmentLabel = TextLabel(size: 13, color: .darkGray, fontLabel: .regular)
    private let tagLabel = TextLabel(size: 14, color: .textGray, fontLabel: .medium)
    
    private let headerEmployeeView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .bottom
        
        return stack
    }()
    
    private let employeeStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 36
        
        image.widthAnchor.constraint(equalToConstant: 72).isActive = true
        image.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ employee: Employee) {
        nameLabel.text = employee.getEmployeeFullName()
        departmentLabel.text = employee.department.title
        tagLabel.text = employee.userTag.lowercased()
        
        avatarImageView.sd_setImage(with: URL(string: employee.avatarUrl), placeholderImage: UIImage(named: "plug.png"))
    }
}

private extension EmployeeCell {
    func setupViews() {
        [avatarImageView, employeeStackView].forEach({ contentView.addSubview($0) })
        
        [nameLabel, tagLabel].forEach({ headerEmployeeView.addArrangedSubview($0) })
        
        [headerEmployeeView, departmentLabel].forEach({ employeeStackView.addArrangedSubview($0) })
    }
    
    func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(8)
            make.left.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
        }
        
        employeeStackView.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(16)
            make.top.right.bottom.equalTo(contentView)
        }
    }
}
