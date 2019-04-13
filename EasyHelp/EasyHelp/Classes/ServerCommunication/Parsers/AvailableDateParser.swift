//
//  AvailableDateParser.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 13/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import SwiftyJSON

class AvailableDateParser: ServerResponseParser {
    var availableDates: [AvailableDate] = []
    
    override func doParse(content: JSON) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        if let jsonArray = content["objects"].array {
            for jsonObj in jsonArray {
                if let dateString = jsonObj["date"].string {
                    
                    let date = dateFormatter.date(from: dateString)
                    var availableHours = [Date]()
                    
                    if let hoursJsonArray = jsonObj["availableHours"].array {
                        for hoursJson in hoursJsonArray {
                            if let hourString = hoursJson.string, let date = dateFormatter.date(from: hourString) {
                                availableHours.append(date)
                            }
                        }
                    }
                    
                    if let date = date {
                        let availableDate = AvailableDate(date: date, availableHours: availableHours)
                        availableDates.append(availableDate)
                    }                    
                }
            }
        }
    }
    
    override func getResult() -> AnyObject? {
        return availableDates as AnyObject
    }
}
