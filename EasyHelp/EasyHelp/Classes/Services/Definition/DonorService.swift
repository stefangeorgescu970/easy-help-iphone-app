//
//  DonorService.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 13/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

protocol DonorService {
    func bookDonation(_ donationBooking: DonationBooking, callback: @escaping (Int?, NSError?) -> ())
    
    func cancelBooking(_ donationBooking: DonationBooking, callback: @escaping (NSError?) -> ())
    
    func sendDonationFormToServer(_ donationForm: DonationForm, callback: @escaping (NSError?) -> ())
    
    func locallyPersistDonationForm(_ donationForm: DonationForm)
    
    func getLocallyPersistedDonationForm() -> DonationForm?
    
    func registerPushToken(_ token: String?, callback: @escaping (NSError?) -> ())
    
    func checkPatientSSN(_ ssn: String, callback: @escaping (NSError?) -> ())
    
    func getDonationHistory(callback: @escaping ([Donation]?, NSError?) -> ())
    
    func getDonationCenters(lat: Double?, long: Double?, callback: @escaping ([DonationCenter]?, NSError?) -> ())
    
    func getAvailableHours(forDonationCenter donationCenter: DonationCenter, callback: @escaping ([AvailableDate]?, NSError?) -> ())
}
