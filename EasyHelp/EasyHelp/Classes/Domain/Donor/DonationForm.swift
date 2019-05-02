//
//  DonationForm.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 22/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DonationForm: NSObject {
    var generalGoodHealth: Bool = false
    var recentLossOfWeight: Bool = false
    var recentInexplicableFever: Bool = false
    var recentStomatoTreatmentOrVaccine: Bool = false
    var currentDrugTreatment: Bool = false
    var sexWithHIVOrHepatitisLast12Months: Bool = false
    var sexWithPersonWhoInjectsDrugsLast12Months: Bool = false
    var sexWithProstituteLast12Months: Bool = false
    var sexWithMultiplePartnersLast12Months: Bool = false
    var injectedDrugs: Bool = false
    var acceptedMoneyOrDrugsForSex: Bool = false
    var changedSexPartnerLast6Months: Bool = false
    var surgeryOrInvestigationsLast12Months: Bool = false
    var tattoosOrPiercingsLast12Months: Bool = false
    var transfusionLast12Months: Bool = false
    var beenPregnant: Bool = false
    var bornLivedTraveledAbroad: Bool = false
    var prisonLastYear: Bool = false
    var exposedHepatitis: Bool = false
    var sufferFromSet1: Bool = false
    var sufferFromSet2: Bool = false
    var sufferFromSet3: Bool = false
    var sufferFromSet4: Bool = false
    var sufferFromSet5: Bool = false
    var sufferFromSet6: Bool = false
    var sufferFromSet7: Bool = false
    var smoker: Bool = false
    var beenRefused: Bool = false
    var requireAttentionPostDonation: Bool = false
    
    var numberOfPartnersLast6Months: Int = -1
    
    var birthDate: String = ""
    var lastMenstruation: String = ""
    var lastAlcoholUse: String = ""
    
    var travelWhere: String = ""
    var travelWhen: String = ""
    var alcoholDrank: String = ""
    var alcoholQuantity: String = ""
    
    override init() {
        super.init()
    }
}
