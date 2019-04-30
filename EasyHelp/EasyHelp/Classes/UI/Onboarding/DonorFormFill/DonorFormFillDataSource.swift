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
                             "Where?"]
    
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
    
    private var answerViews: [UIView] = []
    
    override init() {
        self.answerViews = [goodHealthControl, weightLossControl, feverControl, stomatoVaccineControl,
                            medicalTreatmentControl, sexHivHepaControl, sexDrugUserControl, sexProstituteControl, sexMultiplePartnersControl,
                            injectedDrugsControl, accepdedDrugMoneyForSexControl, changePartenerLast6MonthsControl, numberOfPartStepper,
                            surgeryOrInvestigationsControl, tattoosOrPiercingsControl, transfusionControl, beenPregnantControl,
                            kidBirthDateText, lastMenstruationDateText, abroadControl, whereText, whenText]
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
