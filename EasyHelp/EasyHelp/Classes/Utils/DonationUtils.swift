//
//  DonationUtils.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 25/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DonationUtils: NSObject {
    static func getNumberOfDaysUntilCanDonate(lastDonation: Donation) -> Int? {
        if let daysSinceDonation = DateUtils.getDaysSinceNextDonation(lastDonation: lastDonation) {
            if 72 - daysSinceDonation > 0 {
                return 72 - daysSinceDonation
            }
        }
        
        return nil
    }
}
