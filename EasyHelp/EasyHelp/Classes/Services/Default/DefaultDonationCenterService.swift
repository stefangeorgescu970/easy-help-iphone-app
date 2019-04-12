//
//  DefaultDonationCenterService.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 12/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DefaultDonationCenterService: DonationCenterService {
    func getDonationCenters(callback: @escaping ([DonationCenter]?, NSError?) -> ()) {
        let request = ServerRequest(endpoint: "getAll", controller: "donationCenter")
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            callback(data as? [DonationCenter], nil)
        }, errorBlock: { (error) in
            let error = error as! NSError
            callback(nil, error)
        })
        
        Server.sharedInstance.send(request, parser: DonationCentersParser(), callback: callback, method: .get)
    }
}
