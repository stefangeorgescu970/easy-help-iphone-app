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
            static let logo = "logo-label-main-screen-view"
            static let name = "name-label-main-screen-view"
            static let donated = "donated-label-main-screen-view"
            static let encourage = "encourage-label-main-screen-view"
            static let whyButton = "why-button-main-screen-view"
            static let howButton = "how-button-main-screen-view"
            
            struct TooManyDonations {
                static let view = "too-many-donations-view"
                static let title = "title-label-too-many-donations-view"
                static let subtitle = "subtitle-label-too-many-donations-view"
            }
            
            struct RecentDonation {
                static let view = "recent-donation-view"
                static let title = "title-label-recent-donation-view"
                static let button = "button-recent-donation-view"
            }
            
            struct NextBooking {
                static let view = "next-booking-view"
                static let title = "title-next-booking-view"
                static let bookingIcon = "booking-icon-next-booking-view"
                static let nameLabel = "name-next-booking-view"
                static let dateLabel = "date-next-booking-view"
                static let infoIcon = "info-icon-next-booking-view"
            }
            
            struct CanBook {
                static let view = "can-book-view"
                static let title = "title-label-can-book-view"
                static let subtitle = "subtitle-label-can-book-view"
                static let button = "button-can-book-view"
            }
        }
        
        struct DonationDetails {
            static let view = "donation-details-view"
        }
    }
}
