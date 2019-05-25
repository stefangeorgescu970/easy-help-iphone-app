//
//  DonorSummaryData.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 11/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DonorSummaryData: NSObject {
    var donationNumber: Int = 0
    var lastDonation: Donation?
    var nextBooking: DonationBooking?
    var streakBegin: Date?
}
