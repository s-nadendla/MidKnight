//
//  ViewController.swift
//  MidKnight
//
//  Created by Sai Nadendla on 8/11/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    let outlineLayer = CAShapeLayer()
    let sleepLayer = CAShapeLayer()
    var timeDifference = 0
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    
    @IBOutlet weak var bedtimeStatusLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timeRemaining()
    }
    override func viewDidAppear(_ animated: Bool) {
        //testing line to force tutorial get rid of in future
        //UserDefaults.standard.set(false, forKey: "FirstLaunch")

        if UserDefaults.standard.bool(forKey: "FirstLaunch") {
            // Not First Launch, proceed as normal

        } else {
            // Show tutorial setup (perhaps using performSegueWithIdentifier)
            self.performSegue(withIdentifier: "tutorialLauncher", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createProgressCircle(){

        let percentTime = -((Float(timeDifference) - 1440)/1440)
        let center = CGPoint.init(x: 375/2, y: 210)
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: CGFloat.pi * CGFloat(percentTime) * 3/2, clockwise: true)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 0.96, green: 0.65, blue: 0.13, alpha: 1.00).cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        //shapeLayer.lineCap = kCALineCapRound
        shapeLayer.path = circularPath.cgPath
        
        
        let outlinePath = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        outlineLayer.fillColor = UIColor.clear.cgColor
        outlineLayer.strokeColor = UIColor.white.cgColor
        outlineLayer.lineWidth = 10
        outlineLayer.path = outlinePath.cgPath

        
        
        let sleepPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)
        sleepLayer.fillColor = UIColor.clear.cgColor
        sleepLayer.strokeColor = UIColor(red: 0.42, green: 0.42, blue: 0.42, alpha: 1.00).cgColor
        sleepLayer.lineWidth = 10
        sleepLayer.path = sleepPath.cgPath
        
        view.layer.addSublayer(outlineLayer)
        view.layer.addSublayer(sleepLayer)

        view.layer.addSublayer(shapeLayer)

        animateProgressCircle()
    }
    func animateProgressCircle() {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "circularMotion")
    }
    func timeRemaining(){
        
        timeDifference = calculateTimeDifference()

        let hourRemaining = timeDifference / 60
        let minuteRemaining = timeDifference % 60
        hourLabel.text = String(hourRemaining)
        minuteLabel.text = String(minuteRemaining)
        createProgressCircle()

        
    }
    
    func calculateTimeDifference() -> Int{
        let defaults = UserDefaults.standard
        let sleepHour = defaults.integer(forKey: "sleepHour")
        let sleepMinute = defaults.integer(forKey: "sleepMinute")
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date())
        let currentHour = components.hour!
        let currentMinute = components.minute!
        
        
        let endArray = [sleepHour, sleepMinute]
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
    
    
    @IBAction func sleepButton(_ sender: Any) {

        
        print("sleep state entered")
        let defaults = UserDefaults.standard
        let streak = defaults.integer(forKey: "streak")
        defaults.set(streak + 1,forKey: "streak")
        print("streak \(streak)")

    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "sleepSegue" {
            if (timeDifference < 60){
                return true
            } else {
                let alert = UIAlertController(title: "Not Bedtime!", message: "You can go to sleep one hour before bedtime", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                return false
            }
        }
        else {
            return true
        }

    }
}


