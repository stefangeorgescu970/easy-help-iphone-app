//
//  AvailableDate.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 13/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class AvailableDate: NSObject {
    var date: Date
    var availableHours: [Date]
    
    init(date: Date, availableHours: [Date]) {
        self.date = date
        self.availableHours = availableHours
    }
}
