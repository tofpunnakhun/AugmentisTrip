//
//  AppDelegate.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/5/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import Firebase
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // UI Navigationbar and tabbar
        UINavigationBar.appearance().barTintColor = UIColor(red: 239/255, green: 147/255, blue: 8/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        UITabBar.appearance().tintColor = UIColor(red: 239/255, green: 147/255, blue: 8/255, alpha: 1.0)
        
        // Firbase Confige
        FIRApp.configure()
        
        // Google Place Config
        GMSPlacesClient.provideAPIKey("AIzaSyC6Azy_gUtHmJ46m0tBUMtyFAl6SpZpTc0")
        
        return true
    }

   

}

