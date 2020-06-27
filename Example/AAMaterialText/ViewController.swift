//
//  ViewController.swift
//  AAMaterialText
//
//  Created by engrahsanali on 05/31/2020.
//  Copyright (c) 2020 engrahsanali. All rights reserved.
//

import UIKit
import AAMaterialText

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barButton: UIButton!
    
    var materialEmail: AAMaterialTextInput {
        
        let textField = AAMaterialTextField()
        textField.configure(with: .email,  rightImage: #imageLiteral(resourceName: "ic_login_txt_email"))
        
        let tf = AAMaterialTextInput(textField)
        tf.placeHolderText = "Email"
        
        tf.textDidChange = {
            print($0)
            print(self.isValidEmail($0))
            tf.changeBorder(!self.isValidEmail($0))
        }
    
        return tf
    }
    
    var materialStandard: AAMaterialTextInput {
        
        let textField = AAMaterialTextField()
        textField.configure(with: .standard)
        let tf = AAMaterialTextInput(textField)
        tf.placeHolderText = "Standard"

        return tf
    }
    
    var materialLink: AAMaterialTextInput {
        
        let textField = AAMaterialTextField()
        textField.configure(with: .url,  rightImage:  #imageLiteral(resourceName: "calendar"))
        let tf = AAMaterialTextInput(textField)
        tf.placeHolderText = "URL"

        return tf
    }
    
    var materialNumeric: AAMaterialTextInput {
        
        let textField = AAMaterialTextField()
        textField.configure(with: .numeric, rightImage: #imageLiteral(resourceName: "calendar"))

        let tf = AAMaterialTextInput(textField)
        
        var style = TextViewStyle()
        style.margin.right = 20
        tf.style = style
        
        tf.placeHolderText = "Numeric - Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type."
        
        
        let label = UILabel()
        label.text = "A"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.sizeToFit()
        textField.rightView = label
        textField.rightViewMode = .always
        
        return tf
    }
    
    var materialPhone: AAMaterialTextInput {
        
        let textField = AAMaterialTextField()
        textField.configure(with: .phone)
        
        let tf = AAMaterialTextInput(textField)
        tf.placeHolderText = "Phone Number"

        return tf
    }
    
    var materialDate: AAMaterialTextInput {
        
        let textField = AAMaterialTextField()
        textField.configure(with: .date,  rightImage: #imageLiteral(resourceName: "ic_login_txt_email"))
        
        let tf = AAMaterialTextInput(textField)
        tf.placeHolderText = "Date"
        tf.textDidChange = {
            print($0)
        }
        
        return tf
    }
    
    var materialSelection: AAMaterialTextInput {
        
        let textField = AAMaterialTextField()
        textField.configure(with: .disabled,  rightImage: #imageLiteral(resourceName: "ic_login_txt_email"))
        
        let tf = AAMaterialTextInput(textField)
        tf.placeHolderText = "Selection"
        tf.tapAction = { [weak self] in
            guard let strongself = self else { return }
            strongself.tap()
            } as (() -> Void)
        return tf
    }
    
    var materialMultiline: AAMaterialTextInput {
        
        let textView = AAMaterialTextView()
        textView.textContainerInset = .zero
        textView.backgroundColor = .clear
        textView.isScrollEnabled = true
        textView.autocorrectionType = .no
        
        var style = TextViewStyle()
        
        let multi = AAMaterialTextInput(textView)
        multi.placeHolderText = "Multiline"
        
        multi.placeHolderText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type."
        multi.keyboardAppearance = .dark
        multi.lineSpacing = 0
        multi.style = style
        
        var bottomMargin: CGFloat {
            if let count = multi.text?.count, count > 0 || multi.isActive {
                return 150
            }
            return 70
        }
        
        func updateHeight() {
            style.margin.bottom = bottomMargin

            self.tableView.beginUpdates()
            multi.style = style
            self.tableView.endUpdates()
        }
        
        multi.textDidChange = { _ in
            updateHeight()
        }
        multi.stateDidChange = { _ in
            updateHeight()
        }
        
        return multi
    }
    
    var datasource = [AAMaterialTextInput]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        datasource.append(materialEmail)
        datasource.append(materialStandard)
        datasource.append(materialNumeric)
        datasource.append(materialLink)
        datasource.append(materialPhone)
        datasource.append(materialDate)
        datasource.append(materialSelection)
        datasource.append(materialMultiline)
        
    }
    
    @IBAction func barButtonAction(_ sender: Any) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TextFieldCell
        
        let item = datasource[indexPath.row]
        cell.textView.aa_removeSubViews()
        cell.textView.aa_addAndFitSubview(item)
        
        if indexPath.row != 2 && indexPath.row != 1 {
            item.setText("Some text")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tap() {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemRed
        present(vc, animated: true) {
            
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        guard email.count > 0 else {
            return true
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
}


class TextFieldCell: UITableViewCell {
    
    @IBOutlet weak var textView: UIView!
    
    
}
