//
//  AAMaterialText.swift
//  AAMaterialText
//
//  Created by Muhammad Ahsan Ali on 2020/05/31.
//

import UIKit

class BorderView: UIView {
    
    fileprivate let borderLayer = CAShapeLayer()
    
    var animationDuration: Double = 0.4
    
    var defaultColor = UIColor.gray.withAlphaComponent(0.6) {
        didSet {
            borderLayer.borderColor = defaultColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    fileprivate func setup() {
        borderLayer.borderColor = defaultColor.cgColor
        borderLayer.frame = bounds
        let clearColor = UIColor.clear.cgColor
        borderLayer.borderColor = clearColor
        borderLayer.fillColor = clearColor
        borderLayer.lineWidth = bounds.height
        layer.addSublayer(borderLayer)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        borderLayer.frame = bounds
        borderLayer.lineWidth = bounds.height
    }
    
    func changeColor(with color: UIColor) {
        borderLayer.borderColor = color.cgColor
        animateBorderColor(toColor: UIColor(cgColor: color.cgColor), duration: animationDuration)
    }
    
    func animateState() {
        borderLayer.borderColor = defaultColor.cgColor
        animateBorderColor(toColor: UIColor(cgColor: defaultColor.cgColor), duration: animationDuration)
    }
    
    
}


