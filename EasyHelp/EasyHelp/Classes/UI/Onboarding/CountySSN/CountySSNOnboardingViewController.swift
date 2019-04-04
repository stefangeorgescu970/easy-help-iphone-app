//
//  CountySSNOnboardingViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 03/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class CountySSNOnboardingViewController: UIViewController {
    
    private var arrayOfCounties = ["Please Select County"]
    
    private var headerView = AppInterfaceFormatter.createHeader(title: "Personal Details", subtitle: "We require some personal details from our donors in order to facilitate a proper donation experience.")
    
    private let countyLabel: UILabel = {
        let label = UILabel()
        label.text = "County of Residence"
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
        label.text = "Your Social Security Number"
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
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.darkBlue
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(CountySSNOnboardingViewController.didPressContinue(_:)), for: .touchUpInside)
        
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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        AppServices.miscService.getCounties { (counties, error) in
            if let counties = counties {
                self.arrayOfCounties.append(contentsOf: counties)
            } else {
                // handle error
            }
        }
    }
    
    fileprivate func hasValidData() -> Bool {
        if ssnTextField.text!.isEmpty {
            return false
        }
        
        if countyTextField.text! == arrayOfCounties[0] {
            return false
        }
        
        return true
    }
    
    @objc fileprivate func didPressContinue(_ sender: UIButton) {
        if !hasValidData() {
            self.showError(withText: "Invalid Data")
            return
        }
        
        self.stopShowingError()
    
        AppServices.profileService.updateCountyAndSSN(newCounty: arrayOfCounties[countyPicker.selectedRow(inComponent: 0)], newSSN: ssnTextField.text!) { (error) in
            if let error = error {
                self.showError(withText: error.myErrorInfo)
            } else {
                self.navigationController?.pushViewController(BloodGroupOnboardingViewController(), animated: true)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.frame = CGRect(x: 20, y: 60, width: view.bounds.width - 2 * 20, height: 65)
        
        var currentY = headerView.frame.maxY + 60
        
        countyLabel.frame.origin = CGPoint(x: 20, y: currentY)
        currentY += countyLabel.frame.height + 20
        
        countyTextField.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 40)
        
        currentY += countyTextField.frame.height + 20
        
        ssnLabel.frame.origin = CGPoint(x: 20, y: currentY)
        currentY += ssnLabel.frame.height + 20
        
        ssnTextField.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 40)
        
        continueButton.frame = CGRect(x: 40, y: view.bounds.height - 100, width: view.bounds.width - 80, height: 40)
        
        errorLabel.frame = CGRect(x: 0,
                                  y: continueButton.frame.minY - 40 - 20,
                                  width: UIScreen.main.bounds.width,
                                  height: 40)
        errorLabel.alpha = 1
        self.view.addSubview(errorLabel)
        
        self.view.addSubview(continueButton)
        self.view.addSubview(ssnLabel)
        self.view.addSubview(countyLabel)
        
        self.view.addSubview(headerView)
        self.view.addSubview(countyTextField)
        self.view.addSubview(ssnTextField)
        
        AppInterfaceFormatter.addUnderline(toTextField: countyTextField)
        AppInterfaceFormatter.addUnderline(toTextField: ssnTextField)
        
        countyTextField.textColor = AppColors.darkBlue
        self.view.backgroundColor = AppColors.white
        
        createPickerView()
        createToolbar()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func createPickerView() {
        countyPicker.delegate = self
        countyPicker.delegate?.pickerView?(countyPicker, didSelectRow: 0, inComponent: 0)
        countyTextField.inputView = countyPicker
        countyPicker.backgroundColor = AppColors.white
    }
    
    fileprivate func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = AppColors.darkBlue
        toolbar.backgroundColor = AppColors.white
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CountySSNOnboardingViewController.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        countyTextField.inputAccessoryView = toolbar
        ssnTextField.inputAccessoryView = toolbar
    }
    
    fileprivate func showError(withText: String) {
        errorLabel.text = withText
        
        UIView.animate(withDuration: 0.3) {
            self.errorLabel.alpha = 1
        }
    }
    
    fileprivate func stopShowingError() {
        UIView.animate(withDuration: 0.3) {
            self.errorLabel.alpha = 0
        }
    }
    
    @objc func closePickerView() {
        view.endEditing(true)
    }
}

extension CountySSNOnboardingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfCounties[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countyTextField.text =  arrayOfCounties[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 300
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label:UILabel
        
        if let v = view as? UILabel {
            label = v
        }
        else {
            label = UILabel()
        }
        
        label.textColor = AppColors.darkBlue
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 16)
        
        label.text = arrayOfCounties[row].replacingOccurrences(of: "_", with: " ")
        
        return label
    }
}

extension CountySSNOnboardingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfCounties.count
    }
}
