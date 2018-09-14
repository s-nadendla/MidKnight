//
//  AppDelegate.swift
//  MidKnight
//
//  Created by Sai Nadendla on 8/11/18.
//  Copyright © 2018 Sai Nadendla. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.



    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        if (DidUserPressLockButton()) {
            //User pressed lock button
            print("lockbutton")
        } else {

            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "ViewController") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
            
            //user pressed home button
            print("homebutton")
            let defaults = UserDefaults.standard
            defaults.set(0, forKey: "streak")

            let topMostViewController = UIApplication.shared.topMostViewController()

            if topMostViewController is SleepPage {
                //do something if it's an instance of that class
                print("test")
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                    // Enable or disable features based on authorization.
                    
                }
                
                let content = UNMutableNotificationContent()
                content.title = "It's Sleep Time!"
                content.body = "Turn off your phone"
                content.sound = UNNotificationSound.default()
                
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                
                
                
                let identifier = "UYLLocalNotification"
                let request = UNNotificationRequest(identifier: identifier,
                                                    content: content, trigger: trigger)
                center.add(request, withCompletionHandler: { (error) in
                    if let error = error {
                        // Something went wrong
                        print("error")
                    }
                })
            }

        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
    }

    func applicationDidFinishLaunching(application: UIApplication) {
        if !UserDefaults.standard.bool(forKey: "FirstLaunch") {
            UserDefaults.standard.set(true, forKey: "FirstLaunch")
        }
        
    }
    func DidUserPressLockButton() -> Bool {
        let oldBrightness = UIScreen.main.brightness
        UIScreen.main.brightness = oldBrightness + (oldBrightness <= 0.01 ? (0.01) : (-0.01))
        return oldBrightness != UIScreen.main.brightness
    }
    
}

