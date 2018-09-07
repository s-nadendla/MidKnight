//
//  TutorialPageTwo.swift
//  MidKnight
//
//  Created by Sai Nadendla on 8/15/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


class TutorialPageTwo: UIViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timePicker.backgroundColor = UIColor.black
        timePicker.setValue(UIColor.white, forKey: "textColor")
        
    }
    
    
    func scheduleLocal(hour: Int, minute: Int) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "It is Bedtime"
        content.body = "Check in to go to sleep"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "whater"]
        content.sound = UNNotificationSound.default()
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    
    
    @IBAction func nextButton(_ sender: Any) {
        timePicker.datePickerMode = .time
        
        let date = timePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute,.day,.month,.year], from: date)
        print(date)
        let hour = components.hour!
        let minute = components.minute!
        let day = components.day!
        let month = components.month!
        let year = components.year!

        let defaults = UserDefaults.standard
        defaults.set(date, forKey: "sleepTime")
        defaults.set(day, forKey: "sleepDay")
        defaults.set(month, forKey: "sleepMonth")
        defaults.set(year, forKey: "sleepYear")
        print("TIME PICKER 1:    \(hour)   \(minute)")
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.

        }
        
        scheduleLocal(hour: hour, minute: minute)
    }
}
