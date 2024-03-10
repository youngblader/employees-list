//
//  EmptyView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 9.03.24.
//

import UIKit
import SnapKit

final class EmptyView: UIView {
    private let titleLabel = TextLabel(label: "Мы никого не нашли", size: 17, fontLabel: .semiBold, aligment: .center, linesNumber: 1)
    private let descriptionLabel = TextLabel(label: "Попробуй скорректировать запрос", color: .textGray, fontLabel: .regular, aligment: .center, linesNumber: 1)
    
    private let emptyImageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "loop")
        
        image.widthAnchor.constraint(equalToConstant: 56).isActive = true
        image.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        return image
    }()
    
    private let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension EmptyView {
    func setupViews() {
        self.addSubview(containerView)
        
        containerView.addSubview(emptyImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(80)
            make.left.right.bottom.equalTo(self)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView)
            make.centerX.equalTo(containerView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(8)
            make.centerX.equalTo(containerView)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.centerX.equalTo(containerView)
        }
    }
}
