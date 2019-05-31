//
//  DefaultDonationService.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 13/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DefaultDonorService: DonorService {
    private let myUserDefaults = UserDefaults.standard
    private let userDefaultsKey = "currentDonationForm"
    private let userDefaultsTokenKey = "tokenKey"
    
    func bookDonation(_ donationBooking: DonationBooking, callback: @escaping (NSError?) -> ()) {
        let request = ServerRequest(endpoint: "bookDonation", controller: "donor")
        request.addParameter(key: "userId", value: AppServices.profileService.getCurrentUser()!.id)
        request.addParameter(key: "donationCenterId", value: donationBooking.donationCenter.id)
        request.addParameter(key: "selectedDate", value: DateUtils.getFormattedDate(donationBooking.date))
        request.addParameter(key: "patientSSN", value: donationBooking.patientSSN as Any)
        
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
    
    func sendDonationFormToServer(_ donationForm: DonationForm, callback: @escaping (NSError?) -> ()) {
        let request = ServerRequest(endpoint: "addDonationForm", controller: "donor")
        request.addParameter(key: "donorId", value: AppServices.profileService.getCurrentUser()!.id)
        request.addParameter(key: "generalGoodHealth", value: donationForm.generalGoodHealth)
        request.addParameter(key: "recentLossOfWeight", value: donationForm.recentLossOfWeight)
        request.addParameter(key: "recentInexplicableFever", value: donationForm.recentInexplicableFever)
        request.addParameter(key: "recentStomatoTreatmentOrVaccine", value: donationForm.recentStomatoTreatmentOrVaccine)
        request.addParameter(key: "currentDrugTreatment", value: donationForm.currentDrugTreatment)
        request.addParameter(key: "sexWithHIVOrHepatitisLast12Months", value: donationForm.sexWithHIVOrHepatitisLast12Months)
        request.addParameter(key: "sexWithPersonWhoInjectsDrugsLast12Months", value: donationForm.sexWithPersonWhoInjectsDrugsLast12Months)
        request.addParameter(key: "sexWithProstituteLast12Months", value: donationForm.sexWithProstituteLast12Months)
        request.addParameter(key: "sexWithMultiplePartnersLast12Months", value: donationForm.sexWithMultiplePartnersLast12Months)
        request.addParameter(key: "injectedDrugs", value: donationForm.injectedDrugs)
        request.addParameter(key: "acceptedMoneyOrDrugsForSex", value: donationForm.acceptedMoneyOrDrugsForSex)
        request.addParameter(key: "changedSexPartnerLast6Months", value: donationForm.changedSexPartnerLast6Months)
        request.addParameter(key: "surgeryOrInvestigationsLast12Months", value: donationForm.surgeryOrInvestigationsLast12Months)
        request.addParameter(key: "tattoosOrPiercingsLast12Months", value: donationForm.tattoosOrPiercingsLast12Months)
        request.addParameter(key: "transfusionLast12Months", value: donationForm.transfusionLast12Months)
        request.addParameter(key: "beenPregnant", value: donationForm.beenPregnant)
        request.addParameter(key: "bornLivedTraveledAbroad", value: donationForm.bornLivedTraveledAbroad)
        request.addParameter(key: "prisonLastYear", value: donationForm.prisonLastYear)
        request.addParameter(key: "exposedHepatitis", value: donationForm.exposedHepatitis)
        request.addParameter(key: "sufferFromSet1", value: donationForm.sufferFromSet1)
        request.addParameter(key: "sufferFromSet2", value: donationForm.sufferFromSet2)
        request.addParameter(key: "sufferFromSet3", value: donationForm.sufferFromSet3)
        request.addParameter(key: "sufferFromSet4", value: donationForm.sufferFromSet4)
        request.addParameter(key: "sufferFromSet5", value: donationForm.sufferFromSet5)
        request.addParameter(key: "sufferFromSet6", value: donationForm.sufferFromSet6)
        request.addParameter(key: "sufferFromSet7", value: donationForm.sufferFromSet7)
        request.addParameter(key: "smoker", value: donationForm.smoker)
        request.addParameter(key: "beenRefused", value: donationForm.beenRefused)
        request.addParameter(key: "requireAttentionPostDonation", value: donationForm.requireAttentionPostDonation)
        request.addParameter(key: "numberOfPartnersLast6Months", value: donationForm.numberOfPartnersLast6Months)
        request.addParameter(key: "birthDate", value: donationForm.birthDate)
        request.addParameter(key: "lastMenstruation", value: donationForm.lastMenstruation)
        request.addParameter(key: "lastAlcoholUse", value: donationForm.lastAlcoholUse)
        request.addParameter(key: "travelWhere", value: donationForm.travelWhere)
        request.addParameter(key: "travelWhen", value: donationForm.travelWhen)
        request.addParameter(key: "alcoholDrank", value: donationForm.alcoholDrank)
        request.addParameter(key: "alcoholQuantity", value: donationForm.alcoholQuantity)
        
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
    
    func locallyPersistDonationForm(_ donationForm: DonationForm) {
        let data = NSKeyedArchiver.archivedData(withRootObject: donationForm)
        myUserDefaults.set(data, forKey: userDefaultsKey)
    }
    
    func getLocallyPersistedDonationForm() -> DonationForm? {
        let data = myUserDefaults.object(forKey: userDefaultsKey) as? Data
        return NSKeyedUnarchiver.unarchiveObject(with: data ?? Data()) as? DonationForm
    }
    
    func registerPushToken(_ token: String?, callback: @escaping (NSError?) -> ()) {
        var token = token
        
        if token == nil {
            token = myUserDefaults.string(forKey: userDefaultsTokenKey)
        }
        
        if AppServices.profileService.getCurrentUser() == nil {
            myUserDefaults.set(token, forKey: userDefaultsTokenKey)
            callback(nil)
            return
        }
        
        let request = ServerRequest(endpoint: "registerPushToken", controller: "donor")
        request.addParameter(key: "userId", value: AppServices.profileService.getCurrentUser()!.id)
        request.addParameter(key: "token", value: token!)
        request.addParameter(key: "appPlatform", value: "IOS")
        
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
    
    func checkPatientSSN(_ ssn: String, callback: @escaping (NSError?) -> ()) {
        let request = ServerRequest(endpoint: "checkPatientSSN", controller: "donor")
        request.addParameter(key: "param", value: ssn)
        
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
    
    func getDonationHistory(callback: @escaping ([Donation]?, NSError?) -> ()) {
        let request = ServerRequest(endpoint: "history", controller: "donor")
        request.addParameter(key: "id", value: AppServices.profileService.getCurrentUser()!.id)
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            callback(data as? [Donation], nil)
        }, errorBlock: { (error) in
            let error = error as! NSError
            callback(nil, error)
        })
        
        Server.sharedInstance.send(request, parser: DonationHistoryParser(), callback: callback)
    }
    
    func getDonationCenters(lat: Double?, long: Double?, callback: @escaping ([DonationCenter]?, NSError?) -> ()) {
        let request = ServerRequest(endpoint: "getDonationCenters", controller: "donor")
        request.addParameter(key: "latitude", value: lat as Any)
        request.addParameter(key: "longitude", value: long as Any)
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            callback(data as? [DonationCenter], nil)
        }, errorBlock: { (error) in
            let error = error as! NSError
            callback(nil, error)
        })
        
        Server.sharedInstance.send(request, parser: DonationCentersParser(), callback: callback)
    }
    
    func getAvailableHours(forDonationCenter donationCenter: DonationCenter, callback: @escaping ([AvailableDate]?, NSError?) -> ()) {
        let request = ServerRequest(endpoint: "getAvailableHours", controller: "donor")
        request.addParameter(key: "id", value: donationCenter.id)
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            callback(data as? [AvailableDate], nil)
        }, errorBlock: { (error) in
            let error = error as! NSError
            callback(nil, error)
        })
        
        Server.sharedInstance.send(request, parser: AvailableDateParser(), callback: callback)
    }
}
