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
        return DonorProfileData(id: 1, email: "donor@mail.com", token: "mockToken", firstName: "a", lastName: "b")
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
    
}
