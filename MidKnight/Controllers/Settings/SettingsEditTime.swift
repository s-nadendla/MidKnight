//
//  SettingsEditTime.swift
//  MidKnight
//
//  Created by Sai Nadendla on 9/3/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import UIKit

class SettingsEditTime: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.backgroundColor = UIColor.clear
        timePicker.setValue(UIColor.white, forKey: "textColor")
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
    }
    


}
