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
    
    let mainHeaders = ["First Night","Second Night", "First Week", "First Month", "3 Months", "?","?","?","?","?","?","?","?"]
    override func viewDidLoad() {
        super.viewDidLoad()
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

        cell.mainLabel.text = mainHeaders[indexPath.row]

        
        return cell
    }
    

}
