//
//  AppDelegate.swift
//  EasyHelp
//
//  Created by Georgescu Stefan on 11/09/2018.
//  Copyright © 2018 EasyHelp. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if MOCK
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = UINavigationController(rootViewController: MainMocksTableViewController())
        window?.makeKeyAndVisible()
        
        return true
        
        #else
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : AppColors.appRed]
        navBarAppearance.tintColor = AppColors.appRed
        
        window = UIWindow(frame: UIScreen.main.bounds)
        var vc: UIViewController
        
        if let profileData = AppServices.profileService.getCurrentUser() {
            if profileData.shouldSeeOnboarding() {
                OnboardingFlowManager.instance.startFlow(forDonor: profileData)
                window?.makeKeyAndVisible()
                return true
            } else {
                vc = LandingPageTabBarViewController()
            }
        } else {
            vc = LoginViewController(frame: UIScreen.main.bounds)
        }
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        registerForPushNotifications()
        
        LocationUtils.sharedInstance.requestAuth()
        return true
        
        #endif
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        LocationUtils.sharedInstance.startReceivingLocationChanges()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        LocationUtils.sharedInstance.stopReceivingLocationChanges()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        LocationUtils.sharedInstance.stopReceivingLocationChanges()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        LocationUtils.sharedInstance.stopReceivingLocationChanges()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        
        #if targetEnvironment(simulator)
        
        #else
        AppServices.donorService.registerPushToken(token) { (error) in
            if let error = error {
                // TODO - handle error
            }
        }
        #endif
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            [weak self] granted, error in
            
            print("Permission granted: \(granted)")
            guard granted else { return }
            self?.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UNUserNotificationCenter.current().delegate = PushNotifUtils.sharedInstance
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}

