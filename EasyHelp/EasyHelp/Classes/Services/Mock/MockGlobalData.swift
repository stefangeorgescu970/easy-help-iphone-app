//
//  MockGlobalData.swift
//  EasyHelp Mock
//
//  Created by Stefan Georgescu on 24/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class MockGlobalData: NSObject {
    static let sharedInstance = MockGlobalData()
    
    var summaryHasStreakBegin = false
    var summaryHasLastDonation = false
    var summaryHasBooking = false
    var summaryHasCanHelp = false
    
    private override init() {}
    
    
    func getUncompleteMockProfile() -> DonorProfileData {
        let donor =  DonorProfileData(id: 1, email: "donor@mail.com", token: "mockToken", firstName: "a", lastName: "b", isMale: true)
        donor.county = "ALBA"
        
        return donor
    }
    
    func getMockProfile() -> DonorProfileData {
        let donor = getUncompleteMockProfile()
        
        donor.firstName = "Stefan"
        donor.lastName = "Georgescu"
        
        donor.dateOfBirth = Date(timeIntervalSince1970: 867974400 / 1000)
        donor.county = "CLUJ"
        
        donor.ssn = "1970704035266"
        
        return donor
    }
    
    func defaultDonationCenter() -> DonationCenter {
        return DonationCenter(id: 0, name: "DC", lat: 0, long: 0, address: "some street", county: "ALBA")
    }
    
    func getDonationHistory() -> [Donation] {
        let donation1 = Donation(id: 0, donationCenter: defaultDonationCenter(), date: Date())
        donation1.testResults = DonationTestResults()
        donation1.testResults?.hiv = true
        
        let donation2 = Donation(id: 1, donationCenter: defaultDonationCenter(), date: Date())
//        donation2.testResults = DonationTestResults()
        
        return [donation2, donation1]
    }
    
    func defaultDonation(withTestResult: Bool, badTestResults: Bool) -> Donation {
        let donation = Donation(id: 1, donationCenter: defaultDonationCenter(), date: Date())
        
        if withTestResult {
            let testResult = DonationTestResults()
            testResult.alt = false
            testResult.hepatitisB = false
            testResult.hepatitisC = false
            testResult.vdrl = false
            testResult.htlv = false
            testResult.hiv = badTestResults
            
            donation.testResults = testResult
        }
        
        return donation
    }
    
    func defaultDonationBooking() -> DonationBooking {
        let booking = DonationBooking(date: getDateTomorrowAt9(), donationCenter: defaultDonationCenter())
        
        return booking
    }
    
    private func getDateTomorrowAt9() -> Date {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        
        return Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: tomorrow)!
    }
}
