//
//  DonorService.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 13/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

protocol DonorService {
    func bookDonation(_ donationBooking: DonationBooking, callback: @escaping (NSError?) -> ())
}
