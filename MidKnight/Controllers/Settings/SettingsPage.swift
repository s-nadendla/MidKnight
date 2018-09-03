//
//  SettingsPage.swift
//  MidKnight
//
//  Created by Sai Nadendla on 8/25/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import Foundation
import UIKit


class SettingsPage: UIViewController {
    
    @IBOutlet var settingsRectangle: [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for individualRectangle in self.settingsRectangle {
            individualRectangle.layer.borderWidth = 1
            individualRectangle.layer.borderColor = UIColor(red:0.41, green:0.41, blue:0.41, alpha: 1).cgColor
        }
        
    }
    

    
}
