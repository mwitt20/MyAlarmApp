//
//  SnoozeViewController.swift
//  MyAlarmApp
//
//  Created by Mark Witt on 6/1/20.
//  Copyright © 2020 Mark Witt. All rights reserved.
//

import UIKit
import Foundation

class SnoozeViewController: UIViewController {

    let defaults = UserDefaults.standard
    let hour = Calendar.current.component(.hour, from: Date())
    var main:String = String()
    var early:String = String()
    var late: String = String()

    @IBOutlet weak var earlySwitch: UISwitch!
    @IBOutlet weak var mainSwitch: UISwitch!
    @IBOutlet weak var lateSwitch: UISwitch!
    
    @IBOutlet weak var snoozeButton: UIButton!
    
    @IBOutlet weak var earlyAlarmLabel: UILabel!
    @IBOutlet weak var mainAlarmLabel: UILabel!
    @IBOutlet weak var lateAlarmLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        main = defaults.string(forKey: "main")!
        mainAlarmLabel.text = main
        
        early = defaults.string(forKey: "early")!
        earlyAlarmLabel.text = early
        
        late = defaults.string(forKey: "late")!
        lateAlarmLabel.text = late
        
        snoozeButton.layer.borderWidth = 1.0
        snoozeButton.layer.cornerRadius = 20
        snoozeButton.backgroundColor = UIColor.clear
        
        if 12 <= hour && hour <= 18 {
            view.setColorGradientDay1(colorOne: UIColor(red: 118/225, green: 214/255, blue: 1, alpha: 1)  , colorTwo: UIColor.white , colorThree: UIColor.yellow)

            earlyAlarmLabel.textColor = UIColor.darkText
            mainAlarmLabel.textColor = UIColor.darkText
            lateAlarmLabel.textColor = UIColor.darkText
            
            snoozeButton.setTitleColor(UIColor.darkText, for: .normal)
            snoozeButton.layer.borderColor = UIColor.darkText.cgColor
            
        } else {
            view.setColorGradientNight(colorOne: UIColor.yellow  , colorTwo: UIColor.purple , colorThree: UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0))

            earlyAlarmLabel.textColor = UIColor(red: 249/255, green: 255/255, blue: 225/255, alpha: 1)
            mainAlarmLabel.textColor = UIColor(red: 249/255, green: 255/255, blue: 225/255, alpha: 1)
            lateAlarmLabel.textColor = UIColor(red: 249/255, green: 255/255, blue: 225/255, alpha: 1)
            
            snoozeButton.setTitleColor(UIColor(red: 249/255, green: 255/255, blue: 225/255, alpha: 1), for: .normal)
            snoozeButton.layer.borderColor = UIColor(red: 249/255, green: 255/255, blue: 225/255, alpha: 1).cgColor
        }
        
        

    }
    @IBAction func snoozePressed(_ sender: Any) {
        if mainSwitch.isOn == false && earlySwitch.isOn == false && lateSwitch.isOn == false {
            
            let dateString = main
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.locale = Locale.init(identifier: "identifier")

            let dateObj = dateFormatter.date(from: dateString)
            
            let content = UNMutableNotificationContent()
            content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "I_didn't_get_no_sleep_cause_of_y'all_full_remix.mp3"))
            content.title = "WAKE UP"
            content.body = "YOU ARE LATE"

            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute], from: dateObj! ), repeats: false)
            let mainRequest = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(mainRequest, withCompletionHandler: { error in
                if error != nil {
                    print("something went wrong")
                }
                print("success")
            })
        }
    
    }

}
