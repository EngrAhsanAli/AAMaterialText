//
//  MaterialTextStyle.swift
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
