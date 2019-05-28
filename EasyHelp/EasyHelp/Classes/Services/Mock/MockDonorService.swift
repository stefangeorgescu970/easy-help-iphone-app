//
//  MockDonorService.swift
//  EasyHelp Mock
//
//  Created by Stefan Georgescu on 13/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class MockDonorService: DonorService {
    func bookDonation(_ donationBooking: DonationBooking, callback: @escaping (NSError?) -> ()) {

    }
    
    func getDonationCenters(callback: @escaping ([DonationCenter]?, NSError?) -> ()) {
        
    }
    
    func getAvailableHours(forDonationCenter donationCenter: DonationCenter, callback: @escaping ([AvailableDate]?, NSError?) -> ()) {
        
    }
}
