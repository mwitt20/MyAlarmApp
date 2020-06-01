//
//  ViewController.swift
//  MyAlarmApp
//
//  Created by Mark Witt on 5/22/20.
//  Copyright © 2020 Mark Witt. All rights reserved.
//
import QuartzCore
import UserNotifications
import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    let hour = Calendar.current.component(.hour, from: Date())
    let defaults = UserDefaults.standard
    var main:String = String()
    var early:String = String()
    var late:String = String()
    
    var audioPlayer = AVAudioPlayer()
    
    
    @IBOutlet weak var earlyAlarmLabel: UILabel!
    @IBOutlet weak var mainAlarmLabel: UILabel!
    @IBOutlet weak var lateAlarmLabel: UILabel!
    @IBOutlet weak var snoozeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    //https://stackoverflow.com/questions/8162411/how-to-create-border-in-uibutton/30159869- button border width and color
    //https://stackoverflow.com/questions/55776143/how-to-store-date-in-userdefaults- defaults from Dates
    //https://stackoverflow.com/questions/33277970/how-to-convert-string-to-date-to-string-in-swift-ios/3327837- strings to dates
        
        //https://www.youtube.com/watch?v=E6Cw5WLDe-U- reminders app helped me start out
        
//        do {
//
//            audioPlayer = try AVAudioPlayer(contentsOf:URL.init Bundle.main.path(forResource: "Alarm", ofType: "mp3")
//                audioPlayer.prepareTo
//        }
//        catch{
//            print(error)
//        }
        
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
                let earlyTime = mainTime.addingTimeInterval(TimeInterval(-60.0*10.0))
                let lateTime = mainTime.addingTimeInterval(TimeInterval(60.0*10.0))
                
                let formatter = DateFormatter()
                formatter.dateFormat  = "h:mm a"
                
                self.mainAlarmLabel.text = formatter.string(from: mainTime)
                self.earlyAlarmLabel.text = formatter.string(from: earlyTime)
                self.lateAlarmLabel.text = formatter.string(from: lateTime)
                
                self.defaults.set("\(formatter.string(from: mainTime))", forKey: "main")
                self.defaults.set("\(formatter.string(from: earlyTime))", forKey: "early")
                self.defaults.set("\(formatter.string(from: lateTime))", forKey: "late")
                
                
                
                let content = UNMutableNotificationContent()
                content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "I_didn't_get_no_sleep_cause_of_y'all_full_remix.mp3"))
                content.title = "WAKE UP"
                content.body = "OPEN THE APP TO SNOOZE"

                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute], from: earlyTime), repeats: false)
                let mainRequest = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(mainRequest, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong")
                    }
                })
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
            
    }
    
    
    
}
