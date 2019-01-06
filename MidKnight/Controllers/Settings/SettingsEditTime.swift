//
//  SettingsEditTime.swift
//  MidKnight
//
//  Created by Sai Nadendla on 9/3/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsEditTime: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.backgroundColor = UIColor.clear
        timePicker.setValue(UIColor.white, forKey: "textColor")
        let defaults = UserDefaults.standard
        let minute = defaults.integer(forKey: "sleepMinute")
        let hour = defaults.integer(forKey: "sleepHour")
        let date = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
        timePicker.setDate(date, animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setButton(_ sender: Any) {
        timePicker.datePickerMode = .time
        
        let date = timePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        print(date)
        let hour = components.hour!
        let minute = components.minute!
        
        
        let defaults = UserDefaults.standard
        defaults.set(minute, forKey: "sleepMinute")
        defaults.set(hour, forKey: "sleepHour")
        
        defaults.set(0, forKey: "streak")
        print("TIME PICKER 1:    \(hour)   \(minute)")
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        scheduleLocal(hour: hour, minute: minute)

    }
    func scheduleLocal(hour: Int, minute: Int) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "It is Bedtime"
        content.body = "Check in to go to sleep"
        content.categoryIdentifier = "reminder"
        content.userInfo = ["customData": "dailyNotification"]
        content.sound = UNNotificationSound.default()
        var totalMinutes = (hour * 60) + minute
        totalMinutes = totalMinutes - 15
        let newHour = totalMinutes / 60
        let newMinute = totalMinutes % 60
        var dateComponents = DateComponents()
        dateComponents.hour = newHour
        dateComponents.minute = newMinute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    


}
