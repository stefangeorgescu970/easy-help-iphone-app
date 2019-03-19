//
//  LoginView.swift
//  AcademicInfo
//
//  Created by Stefan Georgescu on 10/11/2018.
//  Copyright © 2018 Stefan Georgescu. All rights reserved.
//

import UIKit
import Foundation


protocol LoginViewDelegate: class {
    func loginView(_ loginView: LoginView, didRequestLogin withEmail: String, withPassword: String)
    func loginViewRequestedSignup(_ loginVieW: LoginView)
}

class LoginView: UIView {
    
    // MARK: - Properties Declaration
    
    fileprivate struct Constants {
        static let fieldSpacing: CGFloat = 40
        static let imageSpacing: CGFloat = 120
    }
    
    private var isShowingError: Bool = false
    weak var delegate: LoginViewDelegate?
    
    // MARK: - View Properties Declaration
    
    private let ubbImageView: UIImageView = {
        let image = UIImage(named: "blood_drop")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private let emailInput: UITextField = {
        let textField = LoginTextField()
        textField.attributedPlaceholder = NSAttributedString(string: Strings.Login.emailPlaceholder(),
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.autocapitalizationType = .none
        textField.textContentType = .emailAddress
        textField.borderStyle = .none
        textField.textColor = .black
        textField.keyboardType = .emailAddress
        
        let origImage = UIImage(named: "email")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        textField.leftViewMode = .always
        textField.leftView = UIImageView(image: tintedImage)
        textField.leftView?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        textField.leftView?.tintColor = AppColors.darkBlue
        
        textField.addTarget(self, action: #selector(LoginView.userEditedText), for: .editingChanged)
        
        return textField
    }()
    
    private let passwordInput: UITextField = {

        let textField = LoginTextField()
        textField.attributedPlaceholder = NSAttributedString(string: Strings.Login.passwordPlaceholder(),
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.borderStyle = .none
        textField.textColor = .black
        
        let origImage = UIImage(named: "lock")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        textField.leftViewMode = .always
        textField.leftView = UIImageView(image: tintedImage)
        textField.leftView?.tintColor = AppColors.darkBlue
        
        textField.addTarget(self, action: #selector(LoginView.userEditedText), for: .editingChanged)
        
        return textField
    }()
    
    private let loginButton: ButtonWithActivity = {
        let button = ButtonWithActivity()
        button.setTitle(Strings.Login.login(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.darkBlue
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(LoginView.didPressLogin), for: .touchUpInside)
        
        return button
    }()
    
    private let signupLabel: UIView = {
        let label = UILabel(frame: CGRect.zero)
        label.text = Strings.Login.noAccount()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(14)
        label.sizeToFit()
        
        return label
    }()
    
    private let goToSignupButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Login.signup(), for: .normal)
        button.setTitleColor(AppColors.almostBlack, for: .normal)
        button.titleLabel?.font = AppFonts.boldFontWithSize(14)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        button.sizeToFit()
        
        button.addTarget(self, action: #selector(LoginView.didPressGoToSignup), for: .touchUpInside)
        
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
    
    private let infoLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.darkBlue
        label.numberOfLines = 2
        label.font = AppFonts.regularFontWithSize(14)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let holder = UIView(frame: frame)
        holder.backgroundColor = .white
        
        ubbImageView.frame = CGRect(x: Constants.imageSpacing,
                                    y: 150,
                                    width: frame.width - 2 * Constants.imageSpacing,
                                    height: frame.width - 2 * Constants.imageSpacing)
        holder.addSubview(ubbImageView)
        
        emailInput.frame = CGRect(x: Constants.fieldSpacing,
                                  y: 300,
                                  width: frame.width - 2 * Constants.fieldSpacing,
                                  height: 40)
        emailInput.delegate = self
        AppInterfaceFormatter.addUnderline(toTextField: emailInput)
        holder.addSubview(emailInput)
        
        passwordInput.frame = CGRect(x: Constants.fieldSpacing,
                                  y: 350,
                                  width: frame.width - 2 * Constants.fieldSpacing,
                                  height: 40)
        passwordInput.delegate = self
        AppInterfaceFormatter.addUnderline(toTextField: passwordInput)
        holder.addSubview(passwordInput)
        
        errorLabel.frame = CGRect(x: 0,
                                  y: 430,
                                  width: frame.width,
                                  height: 40)
        holder.addSubview(errorLabel)
        errorLabel.alpha = 0
        
        loginButton.frame = CGRect(x: Constants.fieldSpacing * 2,
                                   y: 430,
                                   width: frame.width - 4 * Constants.fieldSpacing,
                                   height: 40)
        holder.addSubview(loginButton)
        
        
        let signupRowLength = signupLabel.frame.width + goToSignupButton.frame.width + 5
        
        signupLabel.frame = CGRect(x: (frame.width - signupRowLength) / 2,
                                   y: 480,
                                   width: signupLabel.frame.width,
                                   height: signupLabel.frame.height)
        holder.addSubview(signupLabel)
    
        goToSignupButton.frame = CGRect(x: signupLabel.frame.origin.x + signupLabel.frame.width + 5,
                                   y: 480,
                                   width: goToSignupButton.frame.width,
                                   height: goToSignupButton.frame.height)
        signupLabel.center.y = goToSignupButton.center.y
        holder.addSubview(goToSignupButton)
        
        infoLabel.frame = CGRect(x: Constants.fieldSpacing,
                                 y: 530,
                                 width: frame.width - 2 * Constants.fieldSpacing,
                                 height: 80)
        holder.addSubview(infoLabel)
        infoLabel.alpha = 0
        
        addSubview(holder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setUserAndPass(user: String, pass: String) {
        self.passwordInput.text = pass
        self.emailInput.text = user
    }
    
    func showError(withText: String) {
        if !isShowingError {
            isShowingError = true
            self.errorLabel.text = withText
            UIView.animate(withDuration: 0.3) { [unowned self] in
                self.loginButton.frame = self.loginButton.frame.offsetBy(dx: 0, dy: 50)
                self.signupLabel.frame = self.signupLabel.frame.offsetBy(dx: 0, dy: 50)
                self.goToSignupButton.frame = self.goToSignupButton.frame.offsetBy(dx: 0, dy: 50)
                self.errorLabel.alpha = 1
            }
        }
    }
    
    func stopShowingError() {
        if isShowingError {
            isShowingError = false
            UIView.animate(withDuration: 0.3) { [unowned self] in
                self.loginButton.frame = self.loginButton.frame.offsetBy(dx: 0, dy: -50)
                self.signupLabel.frame = self.signupLabel.frame.offsetBy(dx: 0, dy: -50)
                self.goToSignupButton.frame = self.goToSignupButton.frame.offsetBy(dx: 0, dy: -50)
                self.errorLabel.alpha = 0
            }
        }
    }
    
    func showInfo(withText: String) {
        self.infoLabel.alpha = 1
        self.infoLabel.text = withText
        self.goToSignupButton.isEnabled = true
        self.goToSignupButton.addTarget(self, action: #selector(LoginView.didPressGoToSignup), for: .touchUpInside)
    }
    
    func setButtonLoading(isLoading loading: Bool) {
        loading ? loginButton.showLoading() : loginButton.hideLoading()
    }
    
    func setEmailInput(value: String) {
        emailInput.text = value
    }
    
    // MARK: - Private Methods
    
    @objc private func didPressLogin() {
        let email = emailInput.text!
        let password = passwordInput.text!
        
        emailInput.resignFirstResponder()
        passwordInput.resignFirstResponder()
        
        guard !email.isEmpty, !password.isEmpty else {
            showError(withText: Strings.Errors.Login.fieldsEmpty())
            return
        }
        
//        guard EmailUtils.isValidEmailFormat(email) else {
//            showError(withText: Strings.Errors.Login.invalidEmail())
//            return
//        }
        
        loginButton.showLoading()
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: { [unowned self] in
                self.infoLabel.alpha = 0
            })
        }
        delegate?.loginView(self, didRequestLogin: email, withPassword: password)
    }
    
    @objc private func userEditedText() {
        self.stopShowingError()
    }
    
    @objc private func didPressGoToSignup() {
        emailInput.resignFirstResponder()
        passwordInput.resignFirstResponder()
        delegate?.loginViewRequestedSignup(self)
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
