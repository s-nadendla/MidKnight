//
//  TutorialPageOne.swift
//  MidKnight
//
//  Created by Sai Nadendla on 8/12/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import Foundation
import UIKit


class TutorialPageOne: UIViewController {

    @IBOutlet weak var testText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        testText.text = "Changed"
    }
    @IBAction func testButton(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "FirstLaunch")

    }
}
