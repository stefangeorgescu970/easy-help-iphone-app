//
//  DonationTestResults.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 23/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DonationTestResults: NSObject {
    var hepatitisB: Bool = false
    var hepatitisC: Bool = false
    var hiv: Bool = false
    var htlv: Bool = false
    var vdrl: Bool = false
    var alt: Bool = false
    
    func buildTestedDisease() -> [String: String] {
        var dict = [String: String]()
        
        dict["Hepatitis B"] = DonationTestResults.getTestResult(booleanValue: hepatitisB)
        dict["Hepatitis C"] = DonationTestResults.getTestResult(booleanValue: hepatitisC)
        dict["HIV"] = DonationTestResults.getTestResult(booleanValue: hiv)
        dict["HTLV"] = DonationTestResults.getTestResult(booleanValue: htlv)
        dict["VDRL"] = DonationTestResults.getTestResult(booleanValue: vdrl)
        dict["ALT"] = DonationTestResults.getTestResult(booleanValue: alt)
        
        return dict
    }
    
    private static func getTestResult(booleanValue: Bool) -> String {
        return booleanValue ? "Positive" : "Negative"
    }
}
