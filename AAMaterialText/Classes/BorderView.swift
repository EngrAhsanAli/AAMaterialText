//
//  AAMaterialText.swift
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

class BorderView: UIView {
    
    fileprivate let borderLayer = CAShapeLayer()
    
    var animationDuration: Double = 0.4
    
    var defaultColor = UIColor.gray.withAlphaComponent(0.6) {
        didSet { borderLayer.borderColor = defaultColor.cgColor }
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


