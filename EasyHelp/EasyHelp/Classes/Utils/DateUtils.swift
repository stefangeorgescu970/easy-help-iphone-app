//
//  DateUtils.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 13/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DateUtils: NSObject {
    static func parseServerString(_ stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return dateFormatter.date(from: stringDate)
    }
    
    static func formatDateForServer(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return formatter.string(from: date)
    }
    
    static func getHourIntervalString(fromDate date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let string = formatter.string(from: date)
        let secondString = formatter.string(from: date.addingTimeInterval(1 * 60 * 20))
        
        return "\(string) - \(secondString)"
    }
    
    static func getBookingDateDescription(_ date: Date) -> String {
        let hoursPart = getHourIntervalString(fromDate: date)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let datePart = formatter.string(from: date)
        
        return "\(datePart), \(hoursPart)"
    }
    

    
    static func getDaysSinceNextDonation(lastDonation: Donation) -> Int? {
        let calendar = Calendar.current
        
        let donationDate = calendar.startOfDay(for: lastDonation.date)
        let today = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.day], from: donationDate, to: today)
        
        return components.day
    }
    
    static func getDaysUntilOneYear(fromDate date: Date) -> Int {
        let calendar = Calendar.current
        
        let donationDate = calendar.startOfDay(for: date)
        let today = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.day], from: donationDate, to: today)
        
        return 365 - components.day!
    }
}
