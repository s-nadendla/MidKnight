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
    
    @IBAction func nextButton(_ sender: Any) {
        timePicker.datePickerMode = .time
        
        let date = timePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        print("TIME PICKER 1:    \(hour)   \(minute)")
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.

        }
        
        let content = UNMutableNotificationContent()
        content.title = "It's Bedtime!"
        content.body = "Check in and go to sleep."
        content.sound = UNNotificationSound.default()
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        
        
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                // Something went wrong
                print("error")
            }
        })       
    }
}
