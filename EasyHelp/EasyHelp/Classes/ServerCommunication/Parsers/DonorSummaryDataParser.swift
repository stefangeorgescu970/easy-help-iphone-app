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
        let data = DonorSummaryData()
        
        if let number = content["donationsNumber"].int {
            data.donationNumber = number
        }
        
        donorData = data
    }
    
    override func getResult() -> AnyObject? {
        return donorData as AnyObject
    }
    
}
