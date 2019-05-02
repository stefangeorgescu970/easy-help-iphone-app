//
//  DonorSummaryDataParser.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 12/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import SwiftyJSON

class DonorSummaryDataParser: ServerResponseParser {
    var donorData: DonorSummaryData?
    
    override func doParse(content: JSON) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        let data = DonorSummaryData()
        
        if let number = content["donationsNumber"].int {
            data.donationNumber = number
        }
        
        if content["nextBooking"].exists(), content["nextBooking"]["donationCenter"].exists() {
            let bookingContent = content["nextBooking"]
            let donationCenterContent = bookingContent["donationCenter"]
            if
                let bookingId = bookingContent["id"].int,
                let hourString = bookingContent["bookingDate"].string, let date = dateFormatter.date(from: hourString),
                let dcId = donationCenterContent["id"].int,
                let dcName = donationCenterContent["name"].string,
                let dcCounty = donationCenterContent["county"].string,
                let dcAddress = donationCenterContent["address"].string,
                let dcLat = donationCenterContent["latitude"].double,
                let dcLong = donationCenterContent["longitude"].double {
                let dc = DonationCenter(id: dcId, name: dcName, lat: dcLat, long: dcLong, address: dcAddress, county: dcCounty)
                let booking = DonationBooking(date: date, donationCenter: dc)
                booking.id = bookingId
                data.nextBooking = booking
            }
        }
        
        donorData = data
    }
    
    override func getResult() -> AnyObject? {
        return donorData as AnyObject
    }
}
