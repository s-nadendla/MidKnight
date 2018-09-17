//
//  AchievementsPage.swift
//  MidKnight
//
//  Created by Sai Nadendla on 9/8/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import UIKit

class AchievementsPage: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var achievementProgress: UILabel!
    
    var achievementComplete = 0
    
    let mainHeaders = ["First Steps","First Night","Third Night", "First Week", "First Month", "90 Nights", "180 Nights","365 Nights"]
    let mainImage = ["knight_A1", "knight_A2", "knight_A3", "knight_A4", "knight_A5", "knight_A6", "knight_A7"]
    let subHeaders = ["You Commited to Change","Your Sleep Journey Begins","","","","",""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let unlockArrray = defaults.array(forKey: "unlockArray")
        var trueArray = [Int]()
        for i in 0...6{
            let item = unlockArrray![i] as? Bool ?? Bool()
            if item {
                trueArray.append(0)
            }

        }

        print("true# \(trueArray.count)")
        
        
        achievementProgress.text = String(trueArray.count) + "/13"
        tableView.backgroundColor = .clear

        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCellIdentifier") as! TableViewCellCustom
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        
        let defaults = UserDefaults.standard
        let unlockArrray = defaults.array(forKey: "unlockArray")

        if indexPath.row < 7{
            let cellUnlocked = unlockArrray![indexPath.row] as? Bool ?? Bool()
            if cellUnlocked {
                print(cellUnlocked)
                cell.mainLabel.text = mainHeaders[indexPath.row]
                cell.mainImage.image = UIImage(named: mainImage[indexPath.row])
                cell.subLabel.text = subHeaders[indexPath.row]
            } else {
                cell.mainLabel.text = "Mystery"
                cell.mainImage.image = UIImage(named: "knight_AX")
                cell.subLabel.text = "Continue maintaining a consistent sleep schedule to unlock."

            }

            
        } else {
            cell.mainLabel.text = "Mystery"
            cell.mainImage.image = UIImage(named: "knight_AX")
            cell.subLabel.text = "Continue maintaining a consistent sleep schedule to unlock."
        }


        return cell
    }
    

}
