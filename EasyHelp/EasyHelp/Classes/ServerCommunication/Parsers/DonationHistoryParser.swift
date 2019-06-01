//
//  DonationHistoryParser.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 23/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import SwiftyJSON

class DonationHistoryParser: ServerResponseParser {
    var donations: [Donation] = []
    
    override func doParse(content: JSON) {        
        if let jsonArray = content["objects"].array {
            for donationJson in jsonArray {
                let dcJson = donationJson["donationCenter"]
                guard
                    let dcId = dcJson["id"].int,
                    let name = dcJson["name"].string,
                    let address = dcJson["address"].string,
                    let county = dcJson["county"].string,
                    let lat = dcJson["latitude"].double,
                    let long = dcJson["longitude"].double else {
                        continue
                }
                
                let dc = DonationCenter(id: dcId, name: name, lat: lat, long: long, address: address, county: county)
                
                guard
                    let id = donationJson["id"].int,
                    let dateStr = donationJson["date"].string,
                    let date = DateUtils.parseServerString(dateStr, onlyDate: true) else {
                        continue
                }
                
                let donation = Donation(id: id, donationCenter: dc, date: date)
                
                if let testJson = donationJson["donationTestResultDTO"].dictionary {
                    let testResult = DonationTestResults()
                    testResult.hepatitisB = testJson["hepatitisB"]?.boolValue ?? false
                    testResult.hepatitisC = testJson["hepatitisC"]?.boolValue ?? false
                    testResult.hiv = testJson["hiv"]?.boolValue ?? false
                    testResult.htlv = testJson["htlv"]?.boolValue ?? false
                    testResult.vdrl = testJson["vdrl"]?.boolValue ?? false
                    testResult.alt = testJson["alt"]?.boolValue ?? false
                    
                    donation.testResults = testResult
                }
                
                donations.append(donation)
            }
        }
    }
    
    override func getResult() -> AnyObject? {
        return donations as AnyObject
    }
}
