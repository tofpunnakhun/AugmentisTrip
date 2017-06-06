//
//  AppDelegate.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/5/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 249/255, green: 177/255, blue: 67/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        UITabBar.appearance().tintColor = UIColor(red: 249/255, green: 177/255, blue: 67/255, alpha: 1.0)
        
        FIRApp.configure()
        FIRDatabase.database().reference()
        
        return true
    }

   

}

