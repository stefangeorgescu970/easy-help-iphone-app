//
//  MockDonationCenterService.swift
//  EasyHelp Mock
//
//  Created by Stefan Georgescu on 12/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class MockDonationCenterService: DonationCenterService {
    func getDonationCenters(callback: @escaping ([DonationCenter]?, NSError?) -> ()) {
        
    }
    
    func getAvailableHours(forDonationCenter donationCenter: DonationCenter, callback: @escaping ([AvailableDate]?, NSError?) -> ()) {
        
    }
    
}
