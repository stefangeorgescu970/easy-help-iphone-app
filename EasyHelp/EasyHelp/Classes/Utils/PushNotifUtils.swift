//
//  PushNotifUtils.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 04/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import UserNotifications

class PushNotifUtils: NSObject {
    static let sharedInstance = PushNotifUtils()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private override init() {}
    
    func scheduleLocalNotification(onDate date: Date, withMessage message: String) {
        let content = UNMutableNotificationContent()
        
        content.title = "Easy Help"
        content.body = message
        content.sound = .default
        content.badge = 1
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: "ehnotif-\(message)", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelLocalNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
}
