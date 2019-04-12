//
//  DonationCentersParser.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 12/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import SwiftyJSON

class DonationCentersParser: ServerResponseParser {
    var donationCenters: [DonationCenter] = []
    
    override func doParse(content: JSON) {
        if let jsonArray = content["objects"].array {
            for  dcJson in jsonArray {
                guard
                    let id = dcJson["id"].int,
                    let name = dcJson["name"].string,
                    let address = dcJson["address"].string,
                    let county = dcJson["county"].string,
                    let lat = dcJson["latitude"].double,
                    let long = dcJson["longitude"].double else {
                        continue
                }
                
                let dc = DonationCenter(id: id, name: name, lat: lat, long: long, address: address, county: county)
                donationCenters.append(dc)
            }
        }
    }
    
    override func getResult() -> AnyObject? {
        return donationCenters as AnyObject
    }
}
