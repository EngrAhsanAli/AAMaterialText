//
//  MaterialTextField.swift
//  AAMaterialText
//
//  Created by Muhammad Ahsan Ali on 2020/05/31.
//

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
        if let alignment = (textAttributes?[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle)?.alignment {
            textAlignment = alignment
        }
        return super.becomeFirstResponder()
    }
    
    @objc fileprivate func textFieldDidChange() {
        textInputDelegate?.textInputDidChange(textInput: self)
    }
}

extension AAMaterialTextField: AAInputField {
    
    public func configureInputView(newInputView: UIView) {
        inputView = newInputView
    }
    
    public func changeReturnKeyType(with newReturnKeyType: UIReturnKeyType) {
        returnKeyType = newReturnKeyType
    }
    
    public func currentPosition(from: UITextPosition, offset: Int) -> UITextPosition? {
        return position(from: from, offset: offset)
    }
    
    public func changeClearButtonMode(with newClearButtonMode: UITextField.ViewMode) {
        clearButtonMode = newClearButtonMode
    }
    
    public var currentText: String? {
        get { return text }
        set { self.text = newValue }
    }
    
    public var autocorrection: UITextAutocorrectionType {
        get { return self.autocorrectionType }
        set { self.autocorrectionType = newValue }
    }
    
    @available(iOS 10.0, *)
    public var currentTextContentType: UITextContentType {
        get { return self.textContentType }
        set { self.textContentType = newValue }
    }
    
    public var currentSelectedTextRange: UITextRange? {
        get { return self.selectedTextRange }
        set { self.selectedTextRange = newValue }
    }
    
    public var currentBeginningOfDocument: UITextPosition? {
        get { return self.beginningOfDocument }
    }
    
    public var currentKeyboardAppearance: UIKeyboardAppearance {
        get { return self.keyboardAppearance }
        set { self.keyboardAppearance = newValue}
    }
}

extension AAMaterialTextField: TextInputError {
    
    public func configureErrorState(with message: String?) {
        placeholder = message
        
    }
    
    public func removeErrorHintMessage() {
        placeholder = nil
    }
}

extension AAMaterialTextField: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textInputDelegate?.textInputDidBeginEditing(textInput: self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textInputDelegate?.textInputDidEndEditing(textInput: self)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textInputDelegate?.textInput(textInput: self, shouldChangeCharactersInRange: range, replacementString: string) ?? true
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return textInputDelegate?.textInputShouldBeginEditing(textInput: self) ?? true
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return textInputDelegate?.textInputShouldEndEditing(textInput: self) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textInputDelegate?.textInputShouldReturn(textInput: self) ?? true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
