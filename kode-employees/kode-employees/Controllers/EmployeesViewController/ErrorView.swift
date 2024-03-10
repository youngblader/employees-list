//
//  ErrorView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 9.03.24.
//

import UIKit
import SnapKit

final class ErrorView: UIView {
    var onRetryRequest: (()->())?
    
    private let titleLabel = TextLabel(label: "Какой-то сверхразум все сломал", size: 17, fontLabel: .semiBold, aligment: .center, linesNumber: 1)
    private let descriptionLabel = TextLabel(label: "Постараемся быстро починить", color: .textGray, fontLabel: .regular, aligment: .center, linesNumber: 1)
    
    private let containerView = UIView()
    
    private let emptyImageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "flying-saucer")
        
        image.widthAnchor.constraint(equalToConstant: 56).isActive = true
        image.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        return image
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton()
        
        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 16)
        button.setTitle("Попробовать снова", for: .normal)
        button.setTitleColor(UIColor.primary, for: .normal)
        
        button.addTarget(self, action: #selector(retry), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc private func retry() {
        print("HELLO")
        self.onRetryRequest?()
    }
}

private extension ErrorView {
    func setupViews() {
        self.addSubview(containerView)
        
        containerView.addSubview(emptyImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(retryButton)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.centerY.equalTo(self).offset(80)
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
        
        retryButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.centerX.equalTo(containerView)
        }
    }
}
