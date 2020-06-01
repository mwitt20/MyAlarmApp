//
//  AddViewController.swift
//  MyAlarmApp
//
//  Created by Mark Witt on 5/22/20.
//  Copyright © 2020 Mark Witt. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    let hour = Calendar.current.component(.hour, from: Date())
    
    @IBOutlet var datePicker: UIDatePicker!
    
    public var completion: ((Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.darkText
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        if 12 <= hour && hour <= 18 {
            datePicker.setValue(UIColor.darkText, forKeyPath: "textColor")
            view.setColorGradientDay2(colorOne: UIColor(red: 118/255, green: 214/255, blue: 255/255, alpha: 1), colorTwo: UIColor.white  , colorThree: UIColor.yellow)
            
            
        } else {
            datePicker.setValue(UIColor(red: 249, green: 255, blue: 225, alpha: 1), forKeyPath: "textColor")
            view.setColorGradientNight(colorOne: UIColor.yellow, colorTwo: UIColor.purple  , colorThree: UIColor(red: 0, green: 0, blue: 0.5, alpha: 1))
        }
    }
    
    @objc func didTapSaveButton() {
        let targetDate = datePicker.date
            
        completion?(targetDate)
        
    }
    
}
