//
//  SettingsEditTimeTwo.swift
//  MidKnight
//
//  Created by Sai Nadendla on 9/3/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import UIKit

class SettingsEditTimeTwo: UIViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timePicker.backgroundColor = UIColor.clear
        timePicker.setValue(UIColor.white, forKey: "textColor")
        
        let defaults = UserDefaults.standard
        let minute = defaults.integer(forKey: "wakeMinute")
        let hour = defaults.integer(forKey: "wakeHour")
        
        let date = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
        timePicker.setDate(date, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func setButton(_ sender: Any) {
        timePicker.datePickerMode = .time
        
        let date = timePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        let defaults = UserDefaults.standard
        defaults.set(hour, forKey: "wakeHour")
        defaults.set(minute, forKey: "wakeMinute")
        print("TIME PICKER 2:    \(hour)   \(minute)")
        defaults.set(0, forKey: "streak")
    }
    

}
