//
//  SleepPage.swift
//  MidKnight
//
//  Created by Sai Nadendla on 9/3/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import UIKit

class SleepPage: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)

    }
    @objc func willEnterForeground() {
        let timeDifference = calculateTimeDifference()
        if timeDifference < 30 {
            self.performSegue(withIdentifier: "streakSegue", sender: self)
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    @IBAction func cancelButton(_ sender: Any) {
        

    }
    func calculateTimeDifference() -> Int{
        let defaults = UserDefaults.standard
        let wakeHour = defaults.integer(forKey: "wakeHour")
        let wakeMinute = defaults.integer(forKey: "wakeMinute")
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date())
        let currentHour = components.hour!
        let currentMinute = components.minute!
        
        
        let endArray = [wakeHour, wakeMinute]
        let startArray = [currentHour, currentMinute]
        
        let startHours = Int(startArray[0]) * 60
        let startMinutes = Int(startArray[1]) + startHours
        
        let endHours = Int(endArray[0]) * 60
        let endMinutes = Int(endArray[1]) + endHours
        
        var timeDifference = endMinutes - startMinutes
        
        let day = 24 * 60
        
        if timeDifference < 0 {
            timeDifference += day
        }
        print("TIME DIF: \(timeDifference)")
        return timeDifference
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

        if identifier == "cancelSegue" {

            let alert = UIAlertController(title: "Are You Sure?", message: "Your streak will end.", preferredStyle: UIAlertControllerStyle.alert)
                
            // add an action (button)
            alert.addAction(UIAlertAction(title: "Stay", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Leave", style: UIAlertActionStyle.destructive, handler: { action in
                    
                // do something like...
                let defaults = UserDefaults.standard
                defaults.set(0, forKey: "streak")
                self.performSegue(withIdentifier: "cancelSegue", sender: self)

                    
            }))

                
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return false
            
        }
        if (identifier == "streakSegue") {
            return false
        }
        else {
            return true
        }
    }
}
