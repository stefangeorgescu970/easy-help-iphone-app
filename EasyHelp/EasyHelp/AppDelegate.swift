//
//  AppDelegate.swift
//  EasyHelp
//
//  Created by Georgescu Stefan on 11/09/2018.
//  Copyright © 2018 EasyHelp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navBarAppearance.tintColor = .white
        
        window = UIWindow(frame: UIScreen.main.bounds)
        var vc: UIViewController
        
        if let profileData = AppServices.profileService.getCurrentUser() {
            vc = LandingPageViewController()
        } else {
            vc = LoginViewController(frame: UIScreen.main.bounds)
        }
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

