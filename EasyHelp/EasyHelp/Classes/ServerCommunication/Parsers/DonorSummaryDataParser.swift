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
        
        if content["nextBooking"].exists(), content["nextBooking"]["donationCenter"].exists() {
            let bookingContent = content["nextBooking"]
            let donationCenterContent = bookingContent["donationCenter"]
            if
                let bookingId = bookingContent["id"].int,
                let hourString = bookingContent["bookingDate"].string, let date = DateUtils.parseServerString(hourString),
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
        
        if content["lastDonation"].exists() {
            let donationJson = content["lastDonation"]
            let dcJson = donationJson["donationCenter"]

            if
                let dcId = dcJson["id"].int,
                let name = dcJson["name"].string,
                let address = dcJson["address"].string,
                let county = dcJson["county"].string,
                let lat = dcJson["latitude"].double,
                let long = dcJson["longitude"].double {
                
                let dc = DonationCenter(id: dcId, name: name, lat: lat, long: long, address: address, county: county)
                
                if
                    let id = donationJson["id"].int,
                    let dateStr = donationJson["date"].string,
                    let date = DateUtils.parseServerString(dateStr, onlyDate: true) {
                    
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
                    
                    data.lastDonation = donation
                    
                }
            }
        }
        
        if let hourString = content["streakBegin"].string, let date = DateUtils.parseServerString(hourString) {
            data.streakBegin = date
        }
        
        if let numberOfPeople = content["numberOfPatientsYouCouldHelp"].int {
            data.numberOfPeopleYouCouldHelp = numberOfPeople
        }
        
        if content["donationForm"].exists() {
            let formJson = content["donationForm"]
            let donationForm = DonationForm()
            
            donationForm.generalGoodHealth = formJson["generalGoodHealth"].boolValue
            donationForm.recentLossOfWeight = formJson["recentLossOfWeight"].boolValue
            donationForm.recentInexplicableFever = formJson["recentInexplicableFever"].boolValue
            donationForm.recentStomatoTreatmentOrVaccine = formJson["recentStomatoTreatmentOrVaccine"].boolValue
            donationForm.currentDrugTreatment = formJson["currentDrugTreatment"].boolValue
            donationForm.sexWithHIVOrHepatitisLast12Months = formJson["sexWithHIVOrHepatitisLast12Months"].boolValue
            donationForm.sexWithPersonWhoInjectsDrugsLast12Months = formJson["sexWithPersonWhoInjectsDrugsLast12Months"].boolValue
            donationForm.sexWithProstituteLast12Months = formJson["sexWithProstituteLast12Months"].boolValue
            donationForm.sexWithMultiplePartnersLast12Months = formJson["sexWithMultiplePartnersLast12Months"].boolValue
            donationForm.injectedDrugs = formJson["injectedDrugs"].boolValue
            donationForm.acceptedMoneyOrDrugsForSex = formJson["acceptedMoneyOrDrugsForSex"].boolValue
            donationForm.changedSexPartnerLast6Months = formJson["changedSexPartnerLast6Months"].boolValue
            donationForm.surgeryOrInvestigationsLast12Months = formJson["surgeryOrInvestigationsLast12Months"].boolValue
            donationForm.tattoosOrPiercingsLast12Months = formJson["tattoosOrPiercingsLast12Months"].boolValue
            donationForm.transfusionLast12Months = formJson["transfusionLast12Months"].boolValue
            donationForm.beenPregnant = formJson["beenPregnant"].boolValue
            donationForm.bornLivedTraveledAbroad = formJson["bornLivedTraveledAbroad"].boolValue
            donationForm.prisonLastYear = formJson["prisonLastYear"].boolValue
            donationForm.exposedHepatitis = formJson["exposedHepatitis"].boolValue
            donationForm.sufferFromSet1 = formJson["sufferFromSet1"].boolValue
            donationForm.sufferFromSet2 = formJson["sufferFromSet2"].boolValue
            donationForm.sufferFromSet3 = formJson["sufferFromSet3"].boolValue
            donationForm.sufferFromSet4 = formJson["sufferFromSet4"].boolValue
            donationForm.sufferFromSet5 = formJson["sufferFromSet5"].boolValue
            donationForm.sufferFromSet6 = formJson["sufferFromSet6"].boolValue
            donationForm.sufferFromSet7 = formJson["sufferFromSet7"].boolValue
            donationForm.smoker = formJson["smoker"].boolValue
            donationForm.beenRefused = formJson["beenRefused"].boolValue
            donationForm.requireAttentionPostDonation = formJson["requireAttentionPostDonation"].boolValue
            
            donationForm.numberOfPartnersLast6Months = formJson["numberOfPartnersLast6Months"].intValue
            
            donationForm.birthDate = formJson["birthDate"].stringValue
            donationForm.lastMenstruation = formJson["lastMenstruation"].stringValue
            donationForm.lastAlcoholUse = formJson["lastAlcoholUse"].stringValue
            
            donationForm.travelWhere = formJson["travelWhere"].stringValue
            donationForm.travelWhen = formJson["travelWhen"].stringValue
            donationForm.alcoholDrank = formJson["alcoholDrank"].stringValue
            donationForm.alcoholQuantity = formJson["alcoholQuantity"].stringValue
            
            data.donationForm = donationForm
        }
        
        donorData = data
    }
    
    override func getResult() -> AnyObject? {
        return donorData as AnyObject
    }
}
