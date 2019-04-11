//
//  CountySSNOnboardingView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 11/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

protocol CountySSNOnboardingViewDelegate: class {
    func countySsnOnboardingViewDelegateDidRequestContinue(_ sender: CountySSNOnboardingView, withCountyIndex countyIndex: Int, ssn: String)
}

class CountySSNOnboardingView: UIView {
    
    weak var delegate: CountySSNOnboardingViewDelegate?
    
    private var headerView = AppInterfaceFormatter.createHeader(title: Strings.Onboarding.CountySSN.title(),
                                                                subtitle: Strings.Onboarding.CountySSN.subtitle())
    
    private let countyLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Onboarding.CountySSN.county()
        label.textColor = AppColors.darkBlue
        label.font = AppFonts.boldFontWithSize(18)
        label.sizeToFit()
        return label
    }()
    
    private let countyTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppFonts.regularFontWithSize(16)
        textField.textColor = AppColors.darkBlue
        textField.autocapitalizationType = .none
        textField.borderStyle = .none
        return textField
    }()
    
    private let ssnLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Onboarding.CountySSN.ssn()
        label.textColor = AppColors.darkBlue
        label.font = AppFonts.boldFontWithSize(18)
        label.sizeToFit()
        return label
    }()
    
    private let ssnTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppFonts.regularFontWithSize(16)
        textField.textColor = AppColors.darkBlue
        textField.autocapitalizationType = .none
        textField.borderStyle = .none
        textField.textColor = .black
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let continueButton: ButtonWithActivity = {
        let button = ButtonWithActivity()
        button.setTitle(Strings.Misc.cont(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.darkBlue
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(CountySSNOnboardingView.didPressContinue(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.accentRed
        label.font = AppFonts.boldFontWithSize(16)
        label.contentMode = .center
        label.textAlignment = .center
        return label
    }()
    
    let countyPicker = UIPickerView()
    
    init(frame: CGRect, pickerDelegate: UIPickerViewDelegate, pickerDataSource: UIPickerViewDataSource) {
        super.init(frame: frame)
        
        headerView.frame = CGRect(x: 20, y: 60, width: frame.width - 2 * 20, height: 65)
        
        var currentY = headerView.frame.maxY + 60
        
        countyLabel.frame.origin = CGPoint(x: 20, y: currentY)
        currentY += countyLabel.frame.height + 20
        
        countyTextField.frame = CGRect(x: 20, y: currentY, width: frame.width - 40, height: 40)
        
        currentY += countyTextField.frame.height + 20
        
        ssnLabel.frame.origin = CGPoint(x: 20, y: currentY)
        currentY += ssnLabel.frame.height + 20
        
        ssnTextField.frame = CGRect(x: 20, y: currentY, width: frame.width - 40, height: 40)
        
        continueButton.frame = CGRect(x: 40, y: frame.height - 100, width: frame.width - 80, height: 40)
        
        errorLabel.frame = CGRect(x: 0,
                                  y: continueButton.frame.minY - 40 - 20,
                                  width: UIScreen.main.bounds.width,
                                  height: 40)
        errorLabel.alpha = 1
        self.addSubview(errorLabel)
        
        self.addSubview(continueButton)
        self.addSubview(ssnLabel)
        self.addSubview(countyLabel)
        
        self.addSubview(headerView)
        self.addSubview(countyTextField)
        self.addSubview(ssnTextField)
        
        AppInterfaceFormatter.addUnderline(toTextField: countyTextField)
        AppInterfaceFormatter.addUnderline(toTextField: ssnTextField)
        
        countyTextField.textColor = AppColors.darkBlue
        self.backgroundColor = AppColors.white
        
        createPickerView(delegate: pickerDelegate, dataSource: pickerDataSource)
        createToolbar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCurrentCounty(_ county: String) {
        countyTextField.text = county
    }
    
    func reloadPickerData() {
        countyPicker.reloadAllComponents()
    }
    
    func showError(withText: String) {
        errorLabel.text = withText
        
        UIView.animate(withDuration: 0.3) {
            self.errorLabel.alpha = 1
        }
    }
    
    func stopShowingError() {
        UIView.animate(withDuration: 0.3) {
            self.errorLabel.alpha = 0
        }
    }
    
    fileprivate func createPickerView(delegate: UIPickerViewDelegate, dataSource: UIPickerViewDataSource) {
        countyPicker.delegate = delegate
        countyPicker.dataSource = dataSource
        countyTextField.text = Strings.Onboarding.CountySSN.countyDefaultValue()
        countyTextField.inputView = countyPicker
        countyPicker.backgroundColor = AppColors.white
    }
    
    fileprivate func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = AppColors.darkBlue
        toolbar.backgroundColor = AppColors.white
        let doneButton = UIBarButtonItem(title: Strings.Misc.done(), style: .plain, target: self, action: #selector(CountySSNOnboardingView.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        countyTextField.inputAccessoryView = toolbar
        ssnTextField.inputAccessoryView = toolbar
    }
    
    fileprivate func hasValidData() -> Bool {
        if ssnTextField.text!.isEmpty {
            return false
        }
        
        if countyTextField.text! == Strings.Onboarding.CountySSN.countyDefaultValue() {
            return false
        }
        
        return true
    }
    
    @objc fileprivate func didPressContinue(_ sender: UIButton) {
        if !hasValidData() {
            self.showError(withText: Strings.Errors.Onboarding.invalidData())
            return
        }
        
        self.stopShowingError()
        
        self.delegate?.countySsnOnboardingViewDelegateDidRequestContinue(self, withCountyIndex: countyPicker.selectedRow(inComponent: 0), ssn: ssnTextField.text!)
    }

    @objc func closePickerView() {
        self.endEditing(true)
    }
}
