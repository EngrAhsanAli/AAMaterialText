//
//  MaterialTextField.swift
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

final public class AAMaterialTextField: UITextField {
        
    weak public var textInputDelegate: AAMaterialDelegate?
    
    public var textAttributes: [NSAttributedString.Key: Any]?
    public var contentInset: UIEdgeInsets = .zero
        
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        delegate = self
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @discardableResult
    override public func becomeFirstResponder() -> Bool {
        setAllignment()
        return super.becomeFirstResponder()
    }
    
    @objc fileprivate func textFieldDidChange() {
        textInputDelegate?.textInputDidChange(textInput: self)
    }
    
    func setAllignment() {
        guard let alignment = (textAttributes?[.paragraphStyle] as? NSMutableParagraphStyle)?.alignment else { return }
        textAlignment = alignment
    }
}

extension AAMaterialTextField: AAInputField {
    
    public var currentText: String? {
        get { text }
        set {
            text = newValue
            setAllignment()
        }
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
    
    public var currentSelectedTextRange: UITextRange? {
        get { selectedTextRange }
        set { selectedTextRange = newValue }
    }
    
    public var currentBeginningOfDocument: UITextPosition? {
        get { beginningOfDocument }
    }
    
    public var currentKeyboardAppearance: UIKeyboardAppearance {
        get { keyboardAppearance }
        set { keyboardAppearance = newValue}
    }
    
    public func configureInputView(newInputView: UIView) { inputView = newInputView }
    
    public func changeReturnKeyType(with newReturnKeyType: UIReturnKeyType) { returnKeyType = newReturnKeyType }
    
    public func currentPosition(from: UITextPosition, offset: Int) -> UITextPosition? { position(from: from, offset: offset) }
    
    public func changeClearButtonMode(with newClearButtonMode: UITextField.ViewMode) { clearButtonMode = newClearButtonMode }
    
}

extension AAMaterialTextField: TextInputError {
    
    public func configureErrorState(with message: String?) { placeholder = message }
    
    public func removeErrorHintMessage() { placeholder = nil }
}

extension AAMaterialTextField: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textInputDelegate?.textInputDidBeginEditing(textInput: self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textInputDelegate?.textInputDidEndEditing(textInput: self)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textInputDelegate?.textInput(textInput: self, shouldChangeCharactersInRange: range, replacementString: string) ?? true
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textInputDelegate?.textInputShouldBeginEditing(textInput: self) ?? true
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textInputDelegate?.textInputShouldEndEditing(textInput: self) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textInputDelegate?.textInputShouldReturn(textInput: self) ?? true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        true
    }
}
