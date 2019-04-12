//
//  AppServices.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 19/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class AppServices {
    static var profileService: ProfileService = {
        #if MOCK
        return MockProfileService()
        #else
        return DefaultProfileService()
        #endif
    }()
    
    static var miscService: MiscService = {
        #if MOCK
        return MockMiscService()
        #else
        return DefaultMiscService()
        #endif
    }()
    
    static var donationCenterService: DonationCenterService = {
        #if MOCK
        return MockDonationCenterService()
        #else
        return DefaultDonationCenterService()
        #endif
    }()
}
