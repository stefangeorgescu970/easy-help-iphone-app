//
//  DonorFormFillDataSource.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 30/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonorFormFillDataSource: NSObject, UITableViewDataSource {
    
    private let cellReuseIdentifier = "donor-form-cell"
    
    private let questions = ["Do you consider yourself to be healthy?",
                             "Have you recently had an unexpected weight loss?",
                             "Have you recently had an unexplainable fever?",
                             "Have you recently had any stomatological treatment or any vaccinations?",
                             "Are you following any medical treatment?",
                             "Did you have sexual contact with a partner that had hepatithis or was HIV positive in the last 12 months?",
                             "Did you have sexual contact with a partner that uses intravenous drugs in the last 12 months?",
                             "Did you have sexual contact with a partner that was payed for the act in the last 12 months?",
                             "Did you have sexual contact with a multiple partners in the last 12 months?",
                             "Have you ever used injectable drugs?",
                             "Have you ever accepted drugs or money in exchange for sexual intercourse?",
                             "Have you changed your partner in the last 6 months?",
                             "Number of parteners in the last 6 months?",
                             "Since your last donation or in the last 12 months, did you undergo surgery or medical investigations?",
                             "Since your last donation or in the last 12 months, did you get a tatoo, piercing or any form of acupuncture?",
                             "Since your last donation or in the last 12 months, did you undergo a transfusion?",
                             "For Females: Have you been pregnant?",
                             "Child birth date?",
                             "Last menstruation date?",
                             "Where you born or have you lived or traveled abroad?",
                             "When?",
                             "Where?",
                             "Were you in detention last year?",
                             "Were you exposed to hepatithis? (Sick family members or professional risk)",
                             "Have you ever suffered from icter, tuberculosis, malaria, reumatic fever?",
                             "Have you ever suffered from heart diseases, abnormal arterial pressure?",
                             "Have you ever suffered from cardiac or cerebral accidents?",
                             "Have you ever suffered from asthma?",
                             "Have you ever suffered from convulsions or neurological diseases?",
                             "Have you ever suffered from chronic diseases (diabetes, ulcer, cancer)?",
                             "Have you ever suffered from sexually transmitted diseases?",
                             "Are you a smoker?",
                             "When did you last consume alcohol?",
                             "What alcohol did you consume?",
                             "In what quantity?",
                             "Were you previously refused or postponed at a donation?",
                             "Does your job require special attention 24 hours after the donation? (ex. driver, alpinist, diver)"]
    
    private let goodHealthControl = AppInterfaceFormatter.defaultYesNoControl()
    private let weightLossControl = AppInterfaceFormatter.defaultYesNoControl()
    private let feverControl = AppInterfaceFormatter.defaultYesNoControl()
    private let stomatoVaccineControl = AppInterfaceFormatter.defaultYesNoControl()
    private let medicalTreatmentControl = AppInterfaceFormatter.defaultYesNoControl()
    private let sexHivHepaControl = AppInterfaceFormatter.defaultYesNoControl()
    private let sexDrugUserControl = AppInterfaceFormatter.defaultYesNoControl()
    private let sexProstituteControl = AppInterfaceFormatter.defaultYesNoControl()
    private let sexMultiplePartnersControl = AppInterfaceFormatter.defaultYesNoControl()
    private let injectedDrugsControl = AppInterfaceFormatter.defaultYesNoControl()
    private let accepdedDrugMoneyForSexControl = AppInterfaceFormatter.defaultYesNoControl()
    private let changePartenerLast6MonthsControl = AppInterfaceFormatter.defaultYesNoControl()
    private let numberOfPartStepper = AppInterfaceFormatter.defaultStepperControl()
    private let surgeryOrInvestigationsControl = AppInterfaceFormatter.defaultYesNoControl()
    private let tattoosOrPiercingsControl = AppInterfaceFormatter.defaultYesNoControl()
    private let transfusionControl = AppInterfaceFormatter.defaultYesNoControl()
    private let beenPregnantControl = AppInterfaceFormatter.defaultYesNoControl()
    private let kidBirthDateText = AppInterfaceFormatter.defaultTextField()
    private let lastMenstruationDateText = AppInterfaceFormatter.defaultTextField()
    private let abroadControl = AppInterfaceFormatter.defaultYesNoControl()
    private let whereText = AppInterfaceFormatter.defaultTextField()
    private let whenText = AppInterfaceFormatter.defaultTextField()
    private let detentionControl = AppInterfaceFormatter.defaultYesNoControl()
    private let hepaExposedControl = AppInterfaceFormatter.defaultYesNoControl()
    private let sufferSet1Control = AppInterfaceFormatter.defaultYesNoControl()
    private let sufferSet2Control = AppInterfaceFormatter.defaultYesNoControl()
    private let sufferSet3Control = AppInterfaceFormatter.defaultYesNoControl()
    private let sufferSet4Control = AppInterfaceFormatter.defaultYesNoControl()
    private let sufferSet5Control = AppInterfaceFormatter.defaultYesNoControl()
    private let sufferSet6Control = AppInterfaceFormatter.defaultYesNoControl()
    private let sufferSet7Control = AppInterfaceFormatter.defaultYesNoControl()
    private let smokerControl = AppInterfaceFormatter.defaultYesNoControl()
    private let alcoholWhenText = AppInterfaceFormatter.defaultTextField()
    private let alcoholWhatText = AppInterfaceFormatter.defaultTextField()
    private let alcoholQuantityText = AppInterfaceFormatter.defaultTextField()
    private let previouslyrefusedControl = AppInterfaceFormatter.defaultYesNoControl()
    private let specialAttentionControl = AppInterfaceFormatter.defaultYesNoControl()
    
    private var answerViews: [UIView] = []
    
    override init() {
        self.answerViews = [goodHealthControl, weightLossControl, feverControl, stomatoVaccineControl,
                            medicalTreatmentControl, sexHivHepaControl, sexDrugUserControl, sexProstituteControl, sexMultiplePartnersControl,
                            injectedDrugsControl, accepdedDrugMoneyForSexControl, changePartenerLast6MonthsControl, numberOfPartStepper,
                            surgeryOrInvestigationsControl, tattoosOrPiercingsControl, transfusionControl, beenPregnantControl, kidBirthDateText,
                            lastMenstruationDateText, abroadControl, whereText, whenText, detentionControl, hepaExposedControl, sufferSet1Control,
                            sufferSet2Control, sufferSet3Control, sufferSet4Control, sufferSet5Control, sufferSet6Control, sufferSet7Control,
                            smokerControl, alcoholWhenText, alcoholWhatText, alcoholQuantityText, previouslyrefusedControl,
                            specialAttentionControl]
    }
    
    func allFieldsValid() -> Bool {
        // TODO - remove pregnancy from required
        
        for view in answerViews {
            if let view = view as? UISegmentedControl {
                if !view.isOptionSelected() {
                    return false
                }
            }
        }
        
        return true
    }
    
    func getDonationForm() -> DonationForm {
        let form = DonationForm()
        
        form.generalGoodHealth = goodHealthControl.selectedSegmentIndex == 1
        form.recentLossOfWeight = weightLossControl.selectedSegmentIndex == 1
        form.recentInexplicableFever = feverControl.selectedSegmentIndex == 1
        form.recentStomatoTreatmentOrVaccine = stomatoVaccineControl.selectedSegmentIndex == 1
        form.currentDrugTreatment = medicalTreatmentControl.selectedSegmentIndex == 1
        form.sexWithHIVOrHepatitisLast12Months = sexHivHepaControl.selectedSegmentIndex == 1
        form.sexWithPersonWhoInjectsDrugsLast12Months = sexDrugUserControl.selectedSegmentIndex == 1
        form.sexWithProstituteLast12Months = sexProstituteControl.selectedSegmentIndex == 1
        form.sexWithMultiplePartnersLast12Months = sexMultiplePartnersControl.selectedSegmentIndex == 1
        form.injectedDrugs = injectedDrugsControl.selectedSegmentIndex == 1
        form.acceptedMoneyOrDrugsForSex = accepdedDrugMoneyForSexControl.selectedSegmentIndex == 1
        form.changedSexPartnerLast6Months = changePartenerLast6MonthsControl.selectedSegmentIndex == 1
        form.numberOfPartnersLast6Months = Int(numberOfPartStepper.value)
        form.surgeryOrInvestigationsLast12Months = surgeryOrInvestigationsControl.selectedSegmentIndex == 1
        form.tattoosOrPiercingsLast12Months = tattoosOrPiercingsControl.selectedSegmentIndex == 1
        form.transfusionLast12Months = transfusionControl.selectedSegmentIndex == 1
        form.beenPregnant = beenPregnantControl.selectedSegmentIndex == 1
        form.birthDate = kidBirthDateText.text!
        form.lastMenstruation = lastMenstruationDateText.text!
        form.bornLivedTraveledAbroad = abroadControl.selectedSegmentIndex == 1
        form.travelWhere = whereText.text!
        form.travelWhen = whenText.text!
        form.prisonLastYear = detentionControl.selectedSegmentIndex == 1
        form.exposedHepatitis = hepaExposedControl.selectedSegmentIndex == 1
        form.sufferFromSet1 = sufferSet1Control.selectedSegmentIndex == 1
        form.sufferFromSet2 = sufferSet2Control.selectedSegmentIndex == 1
        form.sufferFromSet3 = sufferSet3Control.selectedSegmentIndex == 1
        form.sufferFromSet4 = sufferSet4Control.selectedSegmentIndex == 1
        form.sufferFromSet5 = sufferSet5Control.selectedSegmentIndex == 1
        form.sufferFromSet6 = sufferSet6Control.selectedSegmentIndex == 1
        form.sufferFromSet7 = sufferSet7Control.selectedSegmentIndex == 1
        form.smoker = smokerControl.selectedSegmentIndex == 1
        form.lastAlcoholUse = alcoholWhenText.text!
        form.alcoholDrank = alcoholWhatText.text!
        form.alcoholQuantity = alcoholQuantityText.text!
        form.beenRefused = previouslyrefusedControl.selectedSegmentIndex == 1
        form.requireAttentionPostDonation = specialAttentionControl.selectedSegmentIndex == 1
    
        return form
    }
    
    func syncWithDonationForm(_ donationForm: DonationForm) {
        goodHealthControl.selectedSegmentIndex = donationForm.generalGoodHealth ? 1 : 0
        weightLossControl.selectedSegmentIndex = donationForm.recentLossOfWeight ? 1 : 0
        feverControl.selectedSegmentIndex = donationForm.recentInexplicableFever ? 1 : 0
        stomatoVaccineControl.selectedSegmentIndex = donationForm.recentStomatoTreatmentOrVaccine ? 1 : 0
        medicalTreatmentControl.selectedSegmentIndex = donationForm.currentDrugTreatment ? 1 : 0
        sexHivHepaControl.selectedSegmentIndex = donationForm.sexWithHIVOrHepatitisLast12Months ? 1 : 0
        sexDrugUserControl.selectedSegmentIndex = donationForm.sexWithPersonWhoInjectsDrugsLast12Months ? 1 : 0
        sexProstituteControl.selectedSegmentIndex = donationForm.sexWithProstituteLast12Months ? 1 : 0
        sexMultiplePartnersControl.selectedSegmentIndex = donationForm.sexWithMultiplePartnersLast12Months ? 1 : 0
        injectedDrugsControl.selectedSegmentIndex = donationForm.injectedDrugs ? 1 : 0
        accepdedDrugMoneyForSexControl.selectedSegmentIndex = donationForm.acceptedMoneyOrDrugsForSex ? 1 : 0
        changePartenerLast6MonthsControl.selectedSegmentIndex = donationForm.changedSexPartnerLast6Months ? 1 : 0
        numberOfPartStepper.value = Double(donationForm.numberOfPartnersLast6Months)
        surgeryOrInvestigationsControl.selectedSegmentIndex = donationForm.surgeryOrInvestigationsLast12Months ? 1 : 0
        tattoosOrPiercingsControl.selectedSegmentIndex = donationForm.tattoosOrPiercingsLast12Months ? 1 : 0
        transfusionControl.selectedSegmentIndex = donationForm.transfusionLast12Months ? 1 : 0
        beenPregnantControl.selectedSegmentIndex = donationForm.beenPregnant ? 1 : 0
        kidBirthDateText.text = donationForm.birthDate
        lastMenstruationDateText.text = donationForm.lastMenstruation
        abroadControl.selectedSegmentIndex = donationForm.bornLivedTraveledAbroad ? 1 : 0
        whereText.text = donationForm.travelWhere
        whenText.text = donationForm.travelWhen
        detentionControl.selectedSegmentIndex = donationForm.prisonLastYear ? 1 : 0
        detentionControl.selectedSegmentIndex = donationForm.prisonLastYear ? 1 : 0
        hepaExposedControl.selectedSegmentIndex = donationForm.exposedHepatitis ? 1 : 0
        sufferSet1Control.selectedSegmentIndex = donationForm.sufferFromSet1 ? 1 : 0
        sufferSet2Control.selectedSegmentIndex = donationForm.sufferFromSet2 ? 1 : 0
        sufferSet3Control.selectedSegmentIndex = donationForm.sufferFromSet3 ? 1 : 0
        sufferSet4Control.selectedSegmentIndex = donationForm.sufferFromSet4 ? 1 : 0
        sufferSet5Control.selectedSegmentIndex = donationForm.sufferFromSet5 ? 1 : 0
        sufferSet6Control.selectedSegmentIndex = donationForm.sufferFromSet6 ? 1 : 0
        sufferSet7Control.selectedSegmentIndex = donationForm.sufferFromSet7 ? 1 : 0
        smokerControl.selectedSegmentIndex = donationForm.smoker ? 1 : 0
        alcoholWhenText.text = donationForm.lastAlcoholUse
        alcoholWhatText.text = donationForm.alcoholDrank
        alcoholQuantityText.text = donationForm.alcoholQuantity
        previouslyrefusedControl.selectedSegmentIndex = donationForm.beenRefused ? 1 : 0
        specialAttentionControl.selectedSegmentIndex = donationForm.requireAttentionPostDonation ? 1 : 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! DonorFormFillCell
        
        cell.syncView(question: questions[indexPath.row], answerView: answerViews[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}
