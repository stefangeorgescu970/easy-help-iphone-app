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
    
    static var donorService: DonorService = {
        #if MOCK
        return MockDonorService()
        #else
        return DefaultDonorService()
        #endif
    }()
}
