//
//  Extensions.swift
//  AAMaterialText_Example
//
//  Created by Muhammad Ahsan Ali on 2020/06/02.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {
    
    func aa_removeSubViews() {
        guard self.subviews.count > 0 else {
            return
        }
        self.subviews.forEach {$0.removeFromSuperview()}
    }
    
    func aa_addAndFitSubview(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        addSubview(subview)
        subview.aa_fitInSuperview(with: insets)
    }
    
    func aa_fitInSuperview(with insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            assertionFailure(" AAMaterialText fitInSuperview was called but view was not in a view hierarchy.")
            return
        }
        
        let applyInset: (NSLayoutConstraint.Attribute, UIEdgeInsets) -> CGFloat = {
            switch $0 {
            case .top: return $1.top
            case .bottom: return -$1.bottom
            case .left: return $1.left
            case .right: return -$1.right
            default:
                return 0
            }
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let attributes = [NSLayoutConstraint.Attribute.top, .left, .right, .bottom]
        superview.addConstraints(attributes.map {
            return NSLayoutConstraint(item: self,
                                      attribute: $0,
                                      relatedBy: .equal,
                                      toItem: superview,
                                      attribute: $0,
                                      multiplier: 1,
                                      constant: applyInset($0, insets))
        })

    }
}
