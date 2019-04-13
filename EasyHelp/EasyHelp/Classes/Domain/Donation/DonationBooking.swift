//
//  DonationBooking.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 13/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DonationBooking: NSObject {
    var date: Date
    var donationCenter: DonationCenter
    
    init(date: Date, donationCenter: DonationCenter) {
        self.date = date
        self.donationCenter = donationCenter
    }
}
