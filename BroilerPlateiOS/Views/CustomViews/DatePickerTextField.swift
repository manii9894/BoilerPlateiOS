//
//  DatePickerTextField.swift
//  AudioBlend
//
//  Created by Abdul Rehman on 26/09/2022.
//

import Foundation
import UIKit

@IBDesignable
class DatePickerTextField: UITextField {
    
    // MARK: - PROPERTIES
    @IBInspectable var minimumDate: Date? = nil
    @IBInspectable var maximumDate: Date = Date()
    private let datePicker = UIDatePicker()
    var pickedDate: Date = Date()
    
    // MARK: - METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        toolbar.setItems([flexButton, doneButton], animated: true)
        self.inputAccessoryView = toolbar
        self.inputView = datePicker
        
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        text = datePicker.date.getString()
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        datePicker.sizeToFit()
        
    }
    
    @objc func handleDatePicker(_ datePicker: UIDatePicker) {
        pickedDate = datePicker.date
        text = datePicker.date.getString()
    }
    
    @objc func donedatePicker(){
        pickedDate = datePicker.date
        text = datePicker.date.getString()
        self.resignFirstResponder()
    }
    
}
