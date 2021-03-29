//
//  MaterialTextStyle.swift
//  AAMaterialText
//
//  Created by Muhammad Ahsan Ali on 2020/05/31.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

public protocol AAMaterialStyle {
    var borderColor: (UIColor, UIColor, UIColor) { get }
    var inputFont: UIFont { get }
    var inputColor: UIColor { get }
    var placeholderMinFont: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var margin: UIEdgeInsets { get }
    var textAttributes: [String: Any]? { get }
}

struct AAMaterialDefaultStyle: AAMaterialStyle {
    let borderColor: (UIColor, UIColor, UIColor) = (#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
    let cornerRadius: CGFloat = 5
    let inputFont = UIFont.systemFont(ofSize: 14)
    let inputColor = UIColor.black
    let placeholderMinFont: CGFloat = 14
    let margin: UIEdgeInsets = .init(top: 10, left: 10, bottom: 40, right: 10)
    let textAttributes: [String: Any]? = nil
    
    init() { }
}

public enum AAMaterialInputType {
    case standard
    case email
    case numeric
    case phone
    case url
    case disabled
    case date
}

public extension AAMaterialTextField {
    
    func configure(with type: AAMaterialInputType, image: UIImage? = nil, isRight: Bool = true) {
        switch type {
            
        case .standard:
            clearButtonMode = .never
            autocorrectionType = .no
            
        case .email:
            clearButtonMode = .whileEditing
            keyboardType = .emailAddress
            autocorrectionType = .no
            autocapitalizationType = .none

        case .numeric:
            clearButtonMode = .whileEditing
            keyboardType = .decimalPad
            autocorrectionType = .no
            
        case .phone:
            clearButtonMode = .whileEditing
            keyboardType = .phonePad
            autocorrectionType = .no
            
            
        case .url:
            clearButtonMode = .whileEditing
            keyboardType = .URL
            autocorrectionType = .no
            autocapitalizationType = .none
            
        case .disabled:
            isUserInteractionEnabled = false
            
        case .date:
            setInputViewDatePicker()

        }
    
        if let image = image {
            setIconView(UIImageView(image: image), isRight: isRight)
        }
        
    }
    
    func setFieldIcon(_ icon: String, font: UIFont, color: UIColor, isRight: Bool) {
        let label = UILabel()
        label.text = icon
        label.textColor = color
        label.font = font
        label.sizeToFit()
        setIconView(label, isRight: isRight)
    }
    
    fileprivate func setIconView(_ view: UIView, isRight: Bool) {
        if isRight {
            rightViewMode = .always
            rightView = view
        }
        else {
            leftViewMode = .always
            leftView = view
        }
    }
}
