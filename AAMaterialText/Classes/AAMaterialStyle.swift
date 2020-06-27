//
//  MaterialTextStyle.swift
//  AAMaterialText
//
//  Created by Muhammad Ahsan Ali on 2020/05/31.
//

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
    
    let borderColor: (UIColor, UIColor, UIColor) = ( #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
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
    
    
    func configure(with type: AAMaterialInputType, rightImage: UIImage? = nil) {
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
    
        if let rightImage = rightImage {
            let imageView = UIImageView(image: rightImage)
            rightView = imageView
            rightViewMode = .always
        }
        
        
    }
    
}
