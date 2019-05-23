//
//  Donation.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 23/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class Donation: NSObject {
    var id: Int
    var donationCenter: DonationCenter
    var testResults: DonationTestResults?
    var date: Date
    
    init(id: Int, donationCenter: DonationCenter, date: Date) {
        self.id = id
        self.donationCenter = donationCenter
        self.date = date
    }
}
