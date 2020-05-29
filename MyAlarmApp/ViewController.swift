//
//  ViewController.swift
//  MyAlarmApp
//
//  Created by Mark Witt on 5/22/20.
//  Copyright © 2020 Mark Witt. All rights reserved.
//

import UserNotifications
import UIKit

class ViewController: UIViewController {
    let hour = Calendar.current.component(.hour, from: Date())

    @IBOutlet weak var earlyAlarmLabel: UILabel!
    @IBOutlet weak var mainAlarmLabel: UILabel!
    @IBOutlet weak var lateAlarmLabel: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if 6 < hour && hour < 18 {
            view.setColorGradientDay1(colorOne: UIColor(red: 118/225, green: 214/255, blue: 1, alpha: 1)  , colorTwo: UIColor.white , colorThree: UIColor.yellow)

            earlyAlarmLabel.textColor = UIColor.darkText
            mainAlarmLabel.textColor = UIColor.darkText
            lateAlarmLabel.textColor = UIColor.darkText
        } else {
            view.setColorGradientNight(colorOne: UIColor.yellow  , colorTwo: UIColor.purple , colorThree: UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0))

            earlyAlarmLabel.textColor = UIColor(red: 249/255, green: 255/255, blue: 225/255, alpha: 1)
            mainAlarmLabel.textColor = UIColor(red: 249/255, green: 255/255, blue: 225/255, alpha: 1)
            lateAlarmLabel.textColor = UIColor(red: 249/255, green: 255/255, blue: 225/255, alpha: 1)
        }

    }
    
    
    func makeNotification(title: String, notificationTime: Date, identifier: String) {
        var content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.body = "Alarm"

        var trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute], from: notificationTime), repeats: false)
        var mainRequest = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(mainRequest, withCompletionHandler: { error in
            if error != nil {
                print("something went wrong")
            }
        })



    }
    
    @IBAction func didTapAdd() {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
            return
        }
        
        vc.title = "New Alarm"
        vc.navigationItem.largeTitleDisplayMode = .never
        

    
        vc.completion = { date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                
                let mainTime = date
                print("\(mainTime)")
                let formatter = DateFormatter()
                formatter.dateFormat  = "h:mm a"
                self.mainAlarmLabel.text = formatter.string(from: date)
                
                let earlyTime = mainTime.addingTimeInterval(-30)
                self.earlyAlarmLabel.text = formatter.string(from: earlyTime)
                
                let lateTime = mainTime.addingTimeInterval(30)
                self.lateAlarmLabel.text = formatter.string(from: lateTime)
                
    
                
                self.makeNotification(title: "main", notificationTime: mainTime, identifier: "main")
                self.makeNotification(title:"early", notificationTime: earlyTime, identifier: "early")
                self.makeNotification(title:"late", notificationTime: lateTime, identifier: "late")
                

            }
            
        }
        navigationController?.pushViewController(vc, animated: true)
            
    }
    
    
    
}
