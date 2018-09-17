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
    
    
    
    @IBAction func nextButton(_ sender: Any) {
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
        var array: [Bool] = [true, false, false, false, false, false, false]

        defaults.set(array, forKey: "unlockArray")
        print("TIME PICKER 1:    \(hour)   \(minute)")
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.

        }
        
        scheduleLocal(hour: hour, minute: minute)
    }
}
