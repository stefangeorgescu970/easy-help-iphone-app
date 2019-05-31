//
//  MockGlobalData.swift
//  EasyHelp Mock
//
//  Created by Stefan Georgescu on 24/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class MockGlobalData: NSObject {
    static func getUncompleteMockProfile() -> DonorProfileData {
        let donor =  DonorProfileData(id: 1, email: "donor@mail.com", token: "mockToken", firstName: "a", lastName: "b", isMale: true)
        donor.county = "ALBA"
        
        return donor
    }
    
    static func getMockProfile() -> DonorProfileData {
        let donor = getUncompleteMockProfile()
        
        donor.firstName = "Stefan"
        donor.lastName = "Georgescu"
        
        donor.dateOfBirth = Date(timeIntervalSince1970: 867974400 / 1000)
        donor.county = "CLUJ"
        
        donor.ssn = "1970704035266"
        
        return donor
    }
    
    static func acceptedAccounts() -> [String: String] {
        return ["don": "1"]
    }
    
    static func defaultDonationCenter() -> DonationCenter {
        return DonationCenter(id: 0, name: "DC", lat: 0, long: 0, address: "some street", county: "ALBA")
    }
    
    static func getDonationHistory() -> [Donation] {
        let donation1 = Donation(id: 0, donationCenter: defaultDonationCenter(), date: Date())
        donation1.testResults = DonationTestResults()
        donation1.testResults?.hiv = true
        
        let donation2 = Donation(id: 1, donationCenter: defaultDonationCenter(), date: Date())
//        donation2.testResults = DonationTestResults()
        
        return [donation2, donation1]
    }
}
