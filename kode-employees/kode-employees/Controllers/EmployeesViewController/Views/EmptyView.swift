//
//  EmptyView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 9.03.24.
//

import UIKit
import SnapKit

final class EmptyView: UIView {
    private let titleLabel = TextLabel(label: "Какой-то сверхразум все сломал", size: 17, fontLabel: .semiBold, linesNumber: 1)
    private let descriptionLabel = TextLabel(label: "Постараемся быстро починить", color: .textGray, fontLabel: .regular, linesNumber: 1)
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 12
        stack.alignment = .center
        
        return stack
    }()

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
        
        button.setTitle("Попробовать снова", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Inter-SemiBold", size: 16)
        button.setTitleColor(UIColor.primary, for: .normal)
        
        button.addTarget(self, action: #selector(didRetryButtonTapped), for: .touchUpInside)

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
    
    @objc private func didRetryButtonTapped() {
        
    }
}

private extension EmptyView {
    func setupViews() {
        self.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(emptyImageView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        contentStackView.addArrangedSubview(retryButton)
    }
    
    func setupConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
