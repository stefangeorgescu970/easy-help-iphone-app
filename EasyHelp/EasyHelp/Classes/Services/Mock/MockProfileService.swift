//
//  MockProfileService.swift
//  EasyHelp Mock
//
//  Created by Stefan Georgescu on 19/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class MockProfileService: ProfileService {
    
    func getCurrentUser() -> DonorProfileData? {
        return MockGlobalData.sharedInstance.getMockProfile()
    }
    
    func saveCurrentUser(_ user: DonorProfileData) {
        
    }
    
    func loginUser(withEmail email: String, andPassword password: String, callback: @escaping (DonorProfileData?, NSError?) -> ()) {
        callback(MockGlobalData.sharedInstance.getUncompleteMockProfile(), nil)
    }
    
    func signupUser(withFirstName firstName: String, withLastName lastName: String, withEmail email: String, withPassword password: String, callback: @escaping (NSError?) -> ()) {
        
    }
    
    func logoutUser(callback: @escaping ((Bool?) -> ())) {

    }
    
    func updateCountyAndSSN(newCounty: String, newSSN: String, callback: @escaping (NSError?) -> ()) {
        callback(nil)
    }
    
    func updateBloodGroup(bloodGroup: String, rh: Bool, callback: @escaping (NSError?) -> ()) {
        callback(nil)
    }
    
    func getDonationSummary(id: Int, callback: @escaping (DonorSummaryData?, NSError?) -> ()) {
        let summary = DonorSummaryData()
        summary.donationNumber = 10
        
        if MockGlobalData.sharedInstance.summaryHasCanHelp {
            summary.numberOfPeopleYouCouldHelp = 5
        }
            
        if MockGlobalData.sharedInstance.summaryHasLastDonation {
            summary.lastDonation = MockGlobalData.sharedInstance.defaultDonation(withTestResult: false, badTestResults: false)
        }
            
        if MockGlobalData.sharedInstance.summaryHasStreakBegin {
            summary.streakBegin = Date()
        }
            
        if MockGlobalData.sharedInstance.summaryHasBooking {
            summary.nextBooking = MockGlobalData.sharedInstance.defaultDonationBooking()
        }
            
        callback(summary, nil)
    }
}
