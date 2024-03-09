//
//  TextLabel.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit

enum FontLabel {
    case regular
    case semiBold
    case bold
    case extraBold
    case extraLight
    case light
    case black
    case medium
    case thin
}

enum ColorStyle {
    case primary
    case textGray
    case backgroundLightGray
    case placeholderGray
    case darkGray
    case black
}

final class TextLabel: UILabel {
    private var textLabel: String
    private var size: CGFloat
    private var aligment: NSTextAlignment
    private var linesNumber: Int
    private var color: ColorStyle
    private var fontLabel: FontLabel
    
    init(label: String = "", size: CGFloat = 16, color: ColorStyle = .black, fontLabel: FontLabel = .semiBold, aligment: NSTextAlignment = .left, linesNumber: Int = 0) {
        
        self.textLabel = label
        self.size = size
        self.color = color
        self.fontLabel = fontLabel
        self.aligment = aligment
        self.linesNumber = linesNumber
        
        super.init(frame: .zero)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TextLabel {
    func configure() {
        configureLabelProperties()
        configureLabelStyle()
        configureLabelColor()
    }
    
    func configureLabelColor() {
        switch color {
        case .primary:
            self.textColor = UIColor.primary
        case .textGray:
            self.textColor = UIColor.textGray
        case .backgroundLightGray:
            self.textColor = UIColor.backgroundLightGray
        case .placeholderGray:
            self.textColor = UIColor.textGray
        case .darkGray:
            self.textColor = UIColor.darkGray
        case .black:
            self.textColor = UIColor.black
        }
    }
    
    func configureLabelStyle() {
        switch fontLabel {
        case .regular:
            self.font = UIFont(name: "Inter-Regular", size: size)
        case .semiBold:
            self.font = UIFont(name: "Inter-SemiBold", size: size)
        case .bold:
            self.font = UIFont(name: "Inter-Bold", size: size)
        case .extraBold:
            self.font = UIFont(name: "Inter-ExtraBold", size: size)
        case .extraLight:
            self.font = UIFont(name: "Inter-ExtraLight", size: size)
        case .light:
            self.font = UIFont(name: "Inter-Light", size: size)
        case .black:
            self.font = UIFont(name: "Inter-Black", size: size)
        case .medium:
            self.font = UIFont(name: "Inter-Medium", size: size)
        case .thin:
            self.font = UIFont(name: "Inter-Thin", size: size)
        }
    }
    
    func configureLabelProperties() {
        self.text = textLabel
        self.numberOfLines = linesNumber
        self.textAlignment = aligment
    }
}
