//
//  DefaultDonationService.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 13/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DefaultDonorService: DonorService {
    func bookDonation(_ donationBooking: DonationBooking, callback: @escaping (NSError?) -> ()) {
        let request = ServerRequest(endpoint: "bookDonation", controller: "donor")
        request.addParameter(key: "id", value: AppServices.profileService.getCurrentUser()!.id)
        request.addParameter(key: "donationCenterId", value: donationBooking.donationCenter.id)
        request.addParameter(key: "selectedDate", value: DateUtils.getFormattedDate(donationBooking.date))
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            if let success = data as? Bool {
                if success {
                    callback(nil)
                    return
                }
            }
            callback(ErrorUtils.getDefaultServerError())
        }, errorBlock: { (error) in
            let error = error as! NSError
            callback(error)
        })
        
        Server.sharedInstance.send(request, parser: ServerResponseParser(), callback: callback)
    }
}
