//
//  AppDelegate.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let splash = UIStoryboard.init(name: "Splash", bundle: nil)
        let viewController = splash.instantiateViewController(withIdentifier: "navigation")
        
        window?.rootViewController = viewController
        
        return true
    }
    
}
