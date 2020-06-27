//
//  MaterialStyles.swift
//  AAMaterialText_Example
//
//  Created by Muhammad Ahsan Ali on 2020/06/02.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import AAMaterialText

struct TextViewStyle: AAMaterialStyle {    
    let borderColor: (UIColor, UIColor, UIColor) = ( #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
    let cornerRadius: CGFloat = 5
    let inputFont = UIFont.systemFont(ofSize: 14)
    let inputColor = UIColor.black
    let placeholderMinFont: CGFloat = 14
    let textAttributes: [String: Any]? = nil
    var margin: UIEdgeInsets = .init(top: 10, left: 10, bottom: 60, right: 10)
    
    init() { }
}
