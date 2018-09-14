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

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    
    @IBOutlet weak var bedtimeStatusLabel: UILabel!
    
    var hourRemaining = ""
    
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
    func createProgressCircle(hourRemaining: Int, minuteRemaining: Int){
        let timeRemaining = float_t(hourRemaining*60 + minuteRemaining)
        let percentTime = -((timeRemaining - 1440)/1440)
        let center = CGPoint.init(x: 375/2, y: 210)
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: CGFloat.pi * CGFloat(percentTime) * 3/2, clockwise: true)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 0.96, green: 0.65, blue: 0.13, alpha: 1.00).cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = kCALineCapRound
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

        
        let defaults = UserDefaults.standard
        
        if let setDate = defaults.object(forKey: "sleepTime") {
            print(setDate)
            let components = Calendar.current.dateComponents([.hour, .minute], from: setDate as! Date)
            print(components.hour!)
            print(components.minute!)
            
            
            let calendar = Calendar.current
            
            var dateComponents: DateComponents? = calendar.dateComponents([.hour, .minute, .second], from: Date())
            
            let currentHour = dateComponents?.hour
            let period = pmOrAm(setHour: components.hour!, currentHour: currentHour!)

            dateComponents?.day = defaults.integer(forKey: "sleepDay") - period
            dateComponents?.month = defaults.integer(forKey: "sleepMonth")
            dateComponents?.year = defaults.integer(forKey: "sleepYear")
            let previousDate: Date? = calendar.date(from: dateComponents!)
            print(previousDate!)
            
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            formatter.allowedUnits = [.hour, .minute]
            formatter.maximumUnitCount = 2   // often, you don't care about seconds if the elapsed time is in months, so you'll set max unit to whatever is appropriate in your case
            

            let duration = formatter.string(from: previousDate as! Date, to: setDate as! Date)
            print(duration!)

            var stringArray = duration?.components(separatedBy: CharacterSet.decimalDigits.inverted)
            
            var hourMinuteArray = [Int]()
            
            for item in stringArray! {
                if let number = Int(item) {
                    hourMinuteArray.append(number)
                }
            }
            
            var minuteRemaining = ""
            let firstChar = Array(duration!)[3]

            if hourMinuteArray.count == 1 {
                if firstChar == "m" || firstChar == "i"{
                    hourRemaining = "0"
                    minuteRemaining = String(hourMinuteArray[0])
                } else {
                    hourRemaining = String(hourMinuteArray[0])
                    minuteRemaining = "0"
                }
            } else {
                hourRemaining = String(hourMinuteArray[0])
                minuteRemaining = String(hourMinuteArray[1])

            }
            print(hourRemaining)
            print(minuteRemaining)
            hourLabel.text = hourRemaining
            minuteLabel.text = minuteRemaining
            createProgressCircle(hourRemaining: Int(hourRemaining)!, minuteRemaining: Int(minuteRemaining)!)

        }
    }
    
    func pmOrAm(setHour: Int, currentHour: Int) -> Int {
        var period = 0
        
        if setHour > 0 && setHour < 12 {
            if currentHour < 12 && currentHour < setHour {
                period = 0
            } else {
                period = 1
            }
        }
        if setHour > 12 && setHour < 24 {
            period = 0
        }
        return period
        
        
    }
    
    
    @IBAction func sleepButton(_ sender: Any) {

        
        print("sleep state entered")
        let defaults = UserDefaults.standard
        let streak = defaults.integer(forKey: "streak")
        defaults.set(streak + 1,forKey: "streak")
        print(streak)
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "sleepSegue" {
            if (Int(hourRemaining)! < 1){
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

