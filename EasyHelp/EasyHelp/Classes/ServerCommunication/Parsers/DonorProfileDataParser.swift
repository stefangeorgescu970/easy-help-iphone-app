//
//  DonorProfileDataParser.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 19/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import SwiftyJSON

class DonorProfileDataParser: ServerResponseParser {
    private var donorProfileData: DonorProfileData? = nil
    
    override func doParse(content: JSON) {
        guard content["user"].exists(),
            let token = content["token"].string,
            let userId = content["user"]["id"].int,
            let email = content["user"]["email"].string,
            let firstName = content["user"]["firstName"].string,
            let lastName = content["user"]["lastName"].string else {
                return
        }
        
        let userContent = content["user"]
        let userData = DonorProfileData(id: userId, email: email, token: token, firstName: firstName, lastName: lastName)
        
        if let county = userContent["county"].string {
            userData.county = county
        }
        
        if let dobEpoch = userContent["dateOfBirth"].double {
            let date = Date(timeIntervalSince1970: dobEpoch / 1000)
            userData.dateOfBirth = date
        }
        
        if let ssn = userContent["ssn"].string {
            userData.ssn = ssn
        }
        
        if let bloodGroup = userContent["bloodGroupLetter"].string {
            userData.bloodGroupLetter = bloodGroup
        }
        
        if let rh = userContent["rh"].bool {
            userData.bloodRh = rh
        }
        
        donorProfileData = userData
    }
    
    override func getResult() -> AnyObject? {
        return donorProfileData
    }
}
