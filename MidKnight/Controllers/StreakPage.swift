//
//  StreakPage.swift
//  MidKnight
//
//  Created by Sai Nadendla on 9/14/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import UIKit

class StreakPage: UIViewController {

    @IBOutlet weak var streakNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard

        let streak = defaults.integer(forKey: "streak")
        print("streak \(streak)")
        streakNumber.text = String(streak)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
