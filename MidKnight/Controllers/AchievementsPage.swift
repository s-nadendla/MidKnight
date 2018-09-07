//
//  AchievementsPage.swift
//  MidKnight
//
//  Created by Sai Nadendla on 8/26/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import Foundation
import UIKit

 




class AchievementsPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let test = ["test1","test2","test3","test4"]
    
    @IBOutlet weak var tableViewAchievements: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell"/*Identifier*/, for: indexPath)
        cell.textLabel?.text = test[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        tableView.backgroundColor = .clear
        cell.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        
        return cell
    }
    
}
