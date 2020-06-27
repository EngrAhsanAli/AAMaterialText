//
//  AAMaterialText+UIView.swift
//  AAMaterialText
//
//  Created by Muhammad Ahsan Ali on 2020/05/31.
//

import UIKit

extension UIView {
    
    func transactionAnimation(with duration: CFTimeInterval, timingFuncion: CAMediaTimingFunction, animations: () -> Void) {
        CATransaction.begin()
        CATransaction.disableActions()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setAnimationTimingFunction(timingFuncion)
        animations()
        CATransaction.commit()
    }
    
    @discardableResult
    func pinConstraint(_ view: UIView, type: NSLayoutConstraint.Attribute, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view,
                                            attribute: type,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: type,
                                            multiplier: 1.0,
                                            constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    func animateBorderColor(toColor: UIColor, duration: Double) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = toColor.cgColor
        animation.duration = duration
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = toColor.cgColor
    }
}

extension UIFont {
    func calculateHeight(text: String, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: self],
                                            context: nil)
        return boundingBox.height
    }
}
