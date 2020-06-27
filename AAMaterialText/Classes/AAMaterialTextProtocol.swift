//
//  MaterialTextStyle.swift
//  AAMaterialText
//
//  Created by Muhammad Ahsan Ali on 2020/05/31.
//

import Foundation

public protocol AAInputField {
    var view: UIView { get }
    var currentText: String? { get set }
    var font: UIFont? { get set }
    var textColor: UIColor? { get set }
    var textAttributes: [NSAttributedString.Key: Any]? { get set }
    var textInputDelegate: AAMaterialDelegate? { get set }
    var currentSelectedTextRange: UITextRange? { get set }
    var currentBeginningOfDocument: UITextPosition? { get }
    var currentKeyboardAppearance: UIKeyboardAppearance { get set }
    var contentInset: UIEdgeInsets { get set }
    var autocorrection: UITextAutocorrectionType {get set}
    @available(iOS 10.0, *)
    var currentTextContentType: UITextContentType { get set }
    
    func configureInputView(newInputView: UIView)
    func changeReturnKeyType(with newReturnKeyType: UIReturnKeyType)
    func currentPosition(from: UITextPosition, offset: Int) -> UITextPosition?
    func changeClearButtonMode(with newClearButtonMode: UITextField.ViewMode)
}

public extension AAInputField where Self: UIView {
    var view: UIView { self }
}

public protocol AAMaterialDelegate: class {
    func textInputDidBeginEditing(textInput: AAInputField)
    func textInputDidEndEditing(textInput: AAInputField)
    func textInputDidChange(textInput: AAInputField)
    func textInput(textInput: AAInputField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    func textInputShouldBeginEditing(textInput: AAInputField) -> Bool
    func textInputShouldEndEditing(textInput: AAInputField) -> Bool
    func textInputShouldReturn(textInput: AAInputField) -> Bool
}

public protocol TextInputError {
    func configureErrorState(with message: String?)
    func removeErrorHintMessage()
}
