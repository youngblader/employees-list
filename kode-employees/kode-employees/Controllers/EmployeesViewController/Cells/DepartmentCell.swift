//
//  DepartmentCell.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit
import SnapKit

final class DepartmentCell: UICollectionViewCell {
    //MARK: - Properties
    static let reuseId = "DepartmentCell"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                nameLabel.textColor = .black
                bottomView.isHidden = false
            } else {
                bottomView.isHidden = true
                nameLabel.textColor = .textGray
            }
        }
    }
    
    //MARK: - Views
    private let nameLabel = TextLabel(size: 15, color: .textGray, fontLabel: .medium, linesNumber: 1)
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        
        view.isHidden = true
        view.backgroundColor = .primary
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
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
    func update(_ item: String) {
        nameLabel.text = item
    }
}

private extension DepartmentCell {
    func setupViews() {
        [nameLabel, bottomView].forEach({ contentView.addSubview($0) })
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(8)
            make.left.right.equalTo(contentView).inset(12)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.right.bottom.equalTo(contentView)
        }
    }
}
