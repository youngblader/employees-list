//
//  RadioButtonView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 7.03.24.
//

import UIKit
import SnapKit

final class RadioButtonView: UIView {
    private let titleLabel = TextLabel(fontLabel: .medium, linesNumber: 1)
    
    lazy var button: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "un-selected"), for: .normal)
        button.setImage(UIImage(named: "selected"), for: .selected)
        
        button.addTarget(self, action: #selector(didRadioButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    init(title: String = "По алфавиту") {
        self.titleLabel.text = title
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didRadioButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
    }
}

private extension RadioButtonView {
    func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(button)
        self.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.bottom.equalTo(self).inset(18)
            make.left.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(button.snp.right).offset(12)
            make.centerY.equalTo(self)
        }
    }
}
