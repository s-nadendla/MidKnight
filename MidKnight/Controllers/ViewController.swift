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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createProgressCircle()
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
        let center = CGPoint.init(x: 375/2, y: 210)
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: CGFloat.pi/3, endAngle: CGFloat.pi , clockwise: true)
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

        
        
        let sleepPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: true)
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
}

