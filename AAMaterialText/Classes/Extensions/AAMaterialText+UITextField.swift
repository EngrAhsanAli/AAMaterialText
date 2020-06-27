//
//  AAMaterialText+UIView.swift
//  AAMaterialText
//
//  Created by Muhammad Ahsan Ali on 2020/05/31.
//

import UIKit

extension UITextField {
    
    func setInputViewDatePicker() {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        self.inputView = datePicker
        
        let toolBar = UIToolbar()
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(tapCancel))
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(tapDone))

        toolBar.setItems([cancel, flexible, doneBtn], animated: false)
        toolBar.sizeToFit()
        self.inputAccessoryView = toolBar
        
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
    @objc func tapDone() {
        if let datePicker = self.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            self.text = dateformatter.string(from: datePicker.date)
        }
        self.resignFirstResponder()
    }
    
}
