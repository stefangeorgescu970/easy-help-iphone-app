//
//  DonationCenter.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 12/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DonationCenter: NSObject {
    var id: Int
    var name: String
    var lat: Double
    var long: Double
    var address: String
    var county: String
    
    init(id: Int, name: String, lat: Double, long: Double, address: String, county: String) {
        self.id = id
        self.name = name
        self.lat = lat
        self.long = long
        self.address = address
        self.county = county
    }
}
