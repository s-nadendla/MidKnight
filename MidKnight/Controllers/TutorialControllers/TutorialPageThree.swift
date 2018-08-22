//
//  TutorialPageThree.swift
//  MidKnight
//
//  Created by Sai Nadendla on 8/15/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import Foundation
import UIKit


class TutorialPageThree: UIViewController {
    
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
        
        let a = timePicker.date
        print("TIME PICKER 2:    \(hour)   \(minute)")
    }
}
