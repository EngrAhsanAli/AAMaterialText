//
//  AAMaterialTextView.swift
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

import Foundation
import UIKit

final public class AAMaterialTextView: UITextView {
    
    public weak var textInputDelegate: AAMaterialDelegate?
    
    public var textAttributes: [NSAttributedString.Key: Any]? {
        didSet {
            guard let attributes = textAttributes else { return }
            typingAttributes = Dictionary(uniqueKeysWithValues: attributes.lazy.map { ($0.key, $0.value) })
        }
    }
    
    public override var font: UIFont? {
        didSet {
            var attributes = typingAttributes
            attributes[.font] = font
            textAttributes = Dictionary(uniqueKeysWithValues: attributes.lazy.map { ($0.key, $0.value)})
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        contentInset = UIEdgeInsets(top: 15, left: -4, bottom: 0, right: 0)
        delegate = self
        backgroundColor = .clear
        isScrollEnabled = true
        autocorrectionType = .no
    }
    
    public override func resignFirstResponder() -> Bool { super.resignFirstResponder() }
    
}

extension AAMaterialTextView: AAInputField {
    
    public var currentText: String? {
        get { text }
        set { text = newValue }
    }
    
    public var currentSelectedTextRange: UITextRange? {
        get { selectedTextRange }
        set { selectedTextRange = newValue }
    }
    
    public var currentKeyboardAppearance: UIKeyboardAppearance {
        get { keyboardAppearance }
        set { keyboardAppearance = newValue}
    }
    
    public var autocorrection: UITextAutocorrectionType {
        get { autocorrectionType }
        set { autocorrectionType = newValue }
    }
    
    @available(iOS 10.0, *)
    public var currentTextContentType: UITextContentType {
        get { textContentType }
        set { textContentType = newValue }
    }
    
    public func configureInputView(newInputView: UIView) { inputView = newInputView }
    
    public var currentBeginningOfDocument: UITextPosition? { beginningOfDocument }
    
    public func changeReturnKeyType(with newReturnKeyType: UIReturnKeyType) { returnKeyType = newReturnKeyType }
    
    public func currentPosition(from: UITextPosition, offset: Int) -> UITextPosition? { position(from: from, offset: offset) }
    
    public func changeClearButtonMode(with newClearButtonMode: UITextField.ViewMode) {}
    
}

extension AAMaterialTextView: UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        textInputDelegate?.textInputDidBeginEditing(textInput: self)
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        textInputDelegate?.textInputDidEndEditing(textInput: self)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        let range = textView.selectedRange
        textView.attributedText = NSAttributedString(string: textView.text, attributes: textAttributes)
        textView.selectedRange = range
        textInputDelegate?.textInputDidChange(textInput: self)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            return textInputDelegate?.textInputShouldReturn(textInput: self) ?? true
        }
        return textInputDelegate?.textInput(textInput: self, shouldChangeCharactersInRange: range, replacementString: text) ?? true
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textInputDelegate?.textInputShouldBeginEditing(textInput: self) ?? true
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textInputDelegate?.textInputShouldEndEditing(textInput: self) ?? true
    }
}
