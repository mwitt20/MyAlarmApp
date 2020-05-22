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
    
    @IBOutlet var table: UITableView!
    
    var alarms = [MyAlarm]()


    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    @IBAction func didTapAdd() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: { success, error in
            if success {
                
            }
            else if error != nil {
                print("error")
            }
        })
        
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
            return
        }
        
        vc.title = "New Alarm"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = MyAlarm(title: title, date: date, identifier: "id_/(date)")
                self.alarms.append(new)
                self.table.reloadData()
                
                let content = UNMutableNotificationContent()
                content.title = "Alarm"
                content.sound = .default
                content.body = "Alarm"
                
                let targetDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
                let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong")
                    }
                })
                
            }
            
        }
        navigationController?.pushViewController(vc, animated: true)
            
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let date = alarms[indexPath.row].date
        let formatter = DateFormatter()
        formatter.dateFormat  = "h:mm a"
        
        cell.textLabel?.text = formatter.string(from: date)
        cell.detailTextLabel?.text = alarms[indexPath.row].title
        
        return cell
    }
}

struct MyAlarm {
    let title: String
    let date: Date
    let identifier: String
}
