//
//  TestStrings.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

struct TestStrings {
    struct Mocks {
        struct MainTableView {
            static let view = "main-table-view"
            static let mainViewCasesCell = "main-view-cases-cell-main-table-view"
            static let donationDetailsCasesCell = "donation-details-cases-cell-main-table-view"
        }
        
        struct MainViewCasesController {
            static let view = "main-view-cases-view"
            static let hasMaxDonationsSwitch = "has-max-donations-switch-main-view-cases-view"
            static let hasRecentlyDonatedSwitch = "has-recently-donated-switch-main-view-cases-view"
            static let hasBookingSwitch = "has-booking-switch-main-view-cases-view"
            static let canHelpDonorSwitch = "can-help-donors-switch-main-view-cases-view"
            static let showViewCell = "show-view-cell-main-view-cases-view"
        }
        
        struct DonationDetailsCasesController {
            static let view = "donation-details-cases-view"
            static let hasResultsSwitch = "has-results-switch-donation-details-cases-view"
            static let areResultsBadSwitch = "are-results-bad-switch-donation-details-cases-view"
            static let showViewCell = "show-view-cell-donation-details-cases-view"
        }
    }
    
    struct App {
        struct MainScreen {
            static let view = "main-screen-view"
        }
        
        struct DonationDetails {
            static let view = "donation-details-view"
        }
    }
}
