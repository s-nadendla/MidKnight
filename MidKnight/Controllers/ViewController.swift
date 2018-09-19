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
    
    
    @IBOutlet weak var checkCircle1: UIImageView!

    @IBOutlet weak var checkCircle2: UIImageView!
    
    @IBOutlet weak var checkCircle3: UIImageView!
    
    @IBOutlet weak var checkCircle4: UIImageView!
    
    @IBOutlet weak var checkCircle5: UIImageView!
    
    @IBOutlet weak var checkCircle6: UIImageView!
    
    @IBOutlet weak var checkCircle7: UIImageView!
    
    
    @IBOutlet weak var adjustedLabel: UILabel!
    @IBOutlet weak var streakIndicator: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var bedtimeStatusLabel: UILabel!
    
    
    var gameTimer: Timer!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let defaults = UserDefaults.standard
        
        if let streakDate = defaults.object(forKey: "streakDate") {
            let currentDate = Date()
            let durationToLastStreak = Int(currentDate.timeIntervalSince(streakDate as! Date))
            print("durationToLastStreak: \(durationToLastStreak)")
            if durationToLastStreak > 90000{
                defaults.set(0, forKey: "streak")

            }
        }
        let streak = defaults.integer(forKey: "streak")

        streakIndicator.text = String(streak)
        gameTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        unlock()
        sleepCycleBar()
        timeRemaining()
    }
    
    
    @objc func runTimedCode() {
        print("Timed Function")
        timeRemaining()
        // your code here will run every hour
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
        print("timerStopped")
        gameTimer.invalidate()
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("timerStopped")
        gameTimer.invalidate()

    }
    func createProgressCircle(){
        timeView.center.x = view.center.x

        let percentTime = -((Float(timeDifference) - 1440)/1440)
        let width = UIScreen.main.bounds.width
        let center = timeView.center
        print("center \(center)")
        let safeAreaTop = self.view.safeAreaInsets.top
        //let center = CGPoint.init(x: width/2, y: 210)
        
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
        print("streak \(streak)")

    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "sleepSegue" {
            if (timeDifference < 60){
                return true
            } else {
                let alert = UIAlertController(title: "Not Bedtime!", message: "You can go to sleep at most one hour before your set bedtime", preferredStyle: UIAlertControllerStyle.alert)
                
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
    func unlock() {
        let defaults = UserDefaults.standard
        var unlockID = defaults.array(forKey: "unlockArray")
        print(unlockID)
        let streak = defaults.integer(forKey: "streak")
        if streak == 1 {
            unlockID![1] = true
        }
        if streak == 3 {
            unlockID![2] = true
            
        }
        if streak == 7 {
            unlockID![3] = true
        }
        if streak == 30 {
            unlockID![4] = true
        }
        if streak == 90 {
            unlockID![5] = true
        }
        if streak == 180 {
            unlockID![6] = true
        }

        print("Unlock Array: \(unlockID)")
        defaults.set(unlockID, forKey: "unlockArray")
    }
    func sleepCycleBar(){
        let defaults = UserDefaults.standard
        let streak = defaults.integer(forKey: "streak")
        if streak == 0 {
            checkCircle1.image = UIImage(named: "CircleBlank")
            checkCircle2.image = UIImage(named: "CircleBlank")
            checkCircle3.image = UIImage(named: "CircleBlank")
            checkCircle4.image = UIImage(named: "CircleBlank")
            checkCircle5.image = UIImage(named: "CircleBlank")
            checkCircle6.image = UIImage(named: "CircleBlank")
            checkCircle7.image = UIImage(named: "CircleBlank")
            adjustedLabel.text = ""
        }
        else if streak == 1 {
            checkCircle1.image = UIImage(named: "CircleChecked")
        }
        else if streak == 2 {
            checkCircle1.image = UIImage(named: "CircleChecked")
            checkCircle2.image = UIImage(named: "CircleChecked")


        }
        else if streak == 3 {
            checkCircle1.image = UIImage(named: "CircleChecked")
            checkCircle2.image = UIImage(named: "CircleChecked")
            checkCircle3.image = UIImage(named: "CircleChecked")

        }
        else if streak == 4 {
            checkCircle1.image = UIImage(named: "CircleChecked")
            checkCircle2.image = UIImage(named: "CircleChecked")
            checkCircle3.image = UIImage(named: "CircleChecked")
            checkCircle4.image = UIImage(named: "CircleChecked")

        }
        else if streak == 5 {
            checkCircle1.image = UIImage(named: "CircleChecked")
            checkCircle2.image = UIImage(named: "CircleChecked")
            checkCircle3.image = UIImage(named: "CircleChecked")
            checkCircle4.image = UIImage(named: "CircleChecked")
            checkCircle5.image = UIImage(named: "CircleChecked")

        }
        else if streak == 6 {
            checkCircle1.image = UIImage(named: "CircleChecked")
            checkCircle2.image = UIImage(named: "CircleChecked")
            checkCircle3.image = UIImage(named: "CircleChecked")
            checkCircle4.image = UIImage(named: "CircleChecked")
            checkCircle5.image = UIImage(named: "CircleChecked")
            checkCircle6.image = UIImage(named: "CircleChecked")

        }
        else if streak >= 7 {
            checkCircle1.image = UIImage(named: "CircleChecked")
            checkCircle2.image = UIImage(named: "CircleChecked")
            checkCircle3.image = UIImage(named: "CircleChecked")
            checkCircle4.image = UIImage(named: "CircleChecked")
            checkCircle5.image = UIImage(named: "CircleChecked")
            checkCircle6.image = UIImage(named: "CircleChecked")
            checkCircle7.image = UIImage(named: "CircleChecked")
            adjustedLabel.text = "Adjusted to Sleep Cycle"

        }
    }
}


