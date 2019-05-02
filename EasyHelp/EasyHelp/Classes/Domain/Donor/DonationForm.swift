//
//  DonationForm.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 22/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DonationForm: NSObject, NSCoding {
    private struct Keys {
        static let generalGoodHealth = "ggh"
        static let recentLossOfWeight = "rlw"
        static let recentInexplicableFever = "rif"
        static let recentStomatoTreatmentOrVaccine = "rstv"
        static let currentDrugTreatment = "cdt"
        static let sexWithHIVOrHepatitisLast12Months = "shh"
        static let sexWithPersonWhoInjectsDrugsLast12Months = "spij"
        static let sexWithProstituteLast12Months = "swp"
        static let sexWithMultiplePartnersLast12Months = "swmp"
        static let injectedDrugs = "ij"
        static let acceptedMoneyOrDrugsForSex = "amds"
        static let changedSexPartnerLast6Months = "csp"
        static let surgeryOrInvestigationsLast12Months = "si"
        static let tattoosOrPiercingsLast12Months = "tp"
        static let transfusionLast12Months = "t"
        static let beenPregnant = "bp"
        static let bornLivedTraveledAbroad = "blta"
        static let prisonLastYear = "ply"
        static let exposedHepatitis = "eh"
        static let sufferFromSet1 = "s1"
        static let sufferFromSet2 = "s2"
        static let sufferFromSet3 = "s3"
        static let sufferFromSet4 = "s4"
        static let sufferFromSet5 = "s5"
        static let sufferFromSet6 = "s6"
        static let sufferFromSet7 = "s7"
        static let smoker = "s"
        static let beenRefused = "br"
        static let requireAttentionPostDonation = "rapd"
        
        static let numberOfPartnersLast6Months = "npl"
        
        static let birthDate = "bd"
        static let lastMenstruation = "lm"
        static let lastAlcoholUse = "lau"
        
        static let travelWhere = "twhr"
        static let travelWhen = "twhn"
        static let alcoholDrank = "ad"
        static let alcoholQuantity = "aq"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(generalGoodHealth, forKey: Keys.generalGoodHealth)
        aCoder.encode(recentLossOfWeight, forKey: Keys.recentLossOfWeight)
        aCoder.encode(recentInexplicableFever, forKey: Keys.recentInexplicableFever)
        aCoder.encode(recentStomatoTreatmentOrVaccine, forKey: Keys.recentStomatoTreatmentOrVaccine)
        aCoder.encode(currentDrugTreatment, forKey: Keys.currentDrugTreatment)
        aCoder.encode(sexWithHIVOrHepatitisLast12Months, forKey: Keys.sexWithHIVOrHepatitisLast12Months)
        aCoder.encode(sexWithPersonWhoInjectsDrugsLast12Months, forKey: Keys.sexWithPersonWhoInjectsDrugsLast12Months)
        aCoder.encode(sexWithProstituteLast12Months, forKey: Keys.sexWithProstituteLast12Months)
        aCoder.encode(sexWithMultiplePartnersLast12Months, forKey: Keys.sexWithMultiplePartnersLast12Months)
        aCoder.encode(injectedDrugs, forKey: Keys.injectedDrugs)
        aCoder.encode(acceptedMoneyOrDrugsForSex, forKey: Keys.acceptedMoneyOrDrugsForSex)
        aCoder.encode(changedSexPartnerLast6Months, forKey: Keys.changedSexPartnerLast6Months)
        aCoder.encode(surgeryOrInvestigationsLast12Months, forKey: Keys.surgeryOrInvestigationsLast12Months)
        aCoder.encode(tattoosOrPiercingsLast12Months, forKey: Keys.tattoosOrPiercingsLast12Months)
        aCoder.encode(transfusionLast12Months, forKey: Keys.transfusionLast12Months)
        aCoder.encode(beenPregnant, forKey: Keys.beenPregnant)
        aCoder.encode(bornLivedTraveledAbroad, forKey: Keys.bornLivedTraveledAbroad)
        aCoder.encode(prisonLastYear, forKey: Keys.prisonLastYear)
        aCoder.encode(exposedHepatitis, forKey: Keys.exposedHepatitis)
        aCoder.encode(sufferFromSet1, forKey: Keys.sufferFromSet1)
        aCoder.encode(sufferFromSet2, forKey: Keys.sufferFromSet2)
        aCoder.encode(sufferFromSet3, forKey: Keys.sufferFromSet3)
        aCoder.encode(sufferFromSet4, forKey: Keys.sufferFromSet4)
        aCoder.encode(sufferFromSet5, forKey: Keys.sufferFromSet5)
        aCoder.encode(sufferFromSet6, forKey: Keys.sufferFromSet6)
        aCoder.encode(sufferFromSet7, forKey: Keys.sufferFromSet7)
        aCoder.encode(smoker, forKey: Keys.smoker)
        aCoder.encode(beenRefused, forKey: Keys.beenRefused)
        aCoder.encode(requireAttentionPostDonation, forKey: Keys.requireAttentionPostDonation)
        aCoder.encode(numberOfPartnersLast6Months, forKey: Keys.numberOfPartnersLast6Months)
        aCoder.encode(birthDate, forKey: Keys.birthDate)
        aCoder.encode(lastMenstruation, forKey: Keys.lastMenstruation)
        aCoder.encode(lastAlcoholUse, forKey: Keys.lastAlcoholUse)
        aCoder.encode(travelWhere, forKey: Keys.travelWhere)
        aCoder.encode(travelWhen, forKey: Keys.travelWhen)
        aCoder.encode(alcoholDrank, forKey: Keys.alcoholDrank)
        aCoder.encode(alcoholQuantity, forKey: Keys.alcoholQuantity)
    }
    
    required init?(coder aDecoder: NSCoder) {
        generalGoodHealth = aDecoder.decodeBool(forKey: Keys.generalGoodHealth)
        recentLossOfWeight = aDecoder.decodeBool(forKey: Keys.recentLossOfWeight)
        recentInexplicableFever = aDecoder.decodeBool(forKey: Keys.recentInexplicableFever)
        recentStomatoTreatmentOrVaccine = aDecoder.decodeBool(forKey: Keys.recentStomatoTreatmentOrVaccine)
        currentDrugTreatment = aDecoder.decodeBool(forKey: Keys.currentDrugTreatment)
        sexWithHIVOrHepatitisLast12Months = aDecoder.decodeBool(forKey: Keys.sexWithHIVOrHepatitisLast12Months)
        sexWithPersonWhoInjectsDrugsLast12Months = aDecoder.decodeBool(forKey: Keys.sexWithPersonWhoInjectsDrugsLast12Months)
        sexWithProstituteLast12Months = aDecoder.decodeBool(forKey: Keys.sexWithProstituteLast12Months)
        sexWithMultiplePartnersLast12Months = aDecoder.decodeBool(forKey: Keys.sexWithMultiplePartnersLast12Months)
        injectedDrugs = aDecoder.decodeBool(forKey: Keys.injectedDrugs)
        acceptedMoneyOrDrugsForSex = aDecoder.decodeBool(forKey: Keys.acceptedMoneyOrDrugsForSex)
        changedSexPartnerLast6Months = aDecoder.decodeBool(forKey: Keys.changedSexPartnerLast6Months)
        surgeryOrInvestigationsLast12Months = aDecoder.decodeBool(forKey: Keys.surgeryOrInvestigationsLast12Months)
        tattoosOrPiercingsLast12Months = aDecoder.decodeBool(forKey: Keys.tattoosOrPiercingsLast12Months)
        transfusionLast12Months = aDecoder.decodeBool(forKey: Keys.transfusionLast12Months)
        beenPregnant = aDecoder.decodeBool(forKey: Keys.beenPregnant)
        bornLivedTraveledAbroad = aDecoder.decodeBool(forKey: Keys.bornLivedTraveledAbroad)
        prisonLastYear = aDecoder.decodeBool(forKey: Keys.prisonLastYear)
        exposedHepatitis = aDecoder.decodeBool(forKey: Keys.exposedHepatitis)
        sufferFromSet1 = aDecoder.decodeBool(forKey: Keys.sufferFromSet1)
        sufferFromSet2 = aDecoder.decodeBool(forKey: Keys.sufferFromSet2)
        sufferFromSet3 = aDecoder.decodeBool(forKey: Keys.sufferFromSet3)
        sufferFromSet4 = aDecoder.decodeBool(forKey: Keys.sufferFromSet4)
        sufferFromSet5 = aDecoder.decodeBool(forKey: Keys.sufferFromSet5)
        sufferFromSet6 = aDecoder.decodeBool(forKey: Keys.sufferFromSet6)
        sufferFromSet7 = aDecoder.decodeBool(forKey: Keys.sufferFromSet7)
        smoker = aDecoder.decodeBool(forKey: Keys.smoker)
        beenRefused = aDecoder.decodeBool(forKey: Keys.beenRefused)
        requireAttentionPostDonation = aDecoder.decodeBool(forKey: Keys.requireAttentionPostDonation)
        
        numberOfPartnersLast6Months = aDecoder.decodeInteger(forKey: Keys.numberOfPartnersLast6Months)

        birthDate = aDecoder.decodeObject(forKey: Keys.birthDate) as! String
        lastMenstruation = aDecoder.decodeObject(forKey: Keys.lastMenstruation) as! String
        lastAlcoholUse = aDecoder.decodeObject(forKey: Keys.lastAlcoholUse) as! String
        travelWhere = aDecoder.decodeObject(forKey: Keys.travelWhere) as! String
        travelWhen = aDecoder.decodeObject(forKey: Keys.travelWhen) as! String
        alcoholDrank = aDecoder.decodeObject(forKey: Keys.alcoholDrank) as! String
        alcoholQuantity = aDecoder.decodeObject(forKey: Keys.alcoholQuantity) as! String
    }
    
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
