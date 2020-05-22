//
//  AddViewController.swift
//  MyAlarmApp
//
//  Created by Mark Witt on 5/22/20.
//  Copyright © 2020 Mark Witt. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    public var completion: ((String, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
    @objc func didTapSaveButton() {
        var titleText = titleField.text
        if titleText!.isEmpty {
            titleText = "Alarm"
        } else {
            titleText = titleField.text
        }
        let targetDate = datePicker.date
            
        completion?(titleText!, targetDate)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
