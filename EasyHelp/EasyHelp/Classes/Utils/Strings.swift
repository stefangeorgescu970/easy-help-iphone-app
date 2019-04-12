//
//  Strings.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 14/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

struct Strings {
    struct ProfileDetails {
        static let faq = { "Frequently Asked Questions" }
        static let termsConds = { "Terms and Conditions" }
        static let bloodGroupHeader = { "Your Blood Group" }
        static let formHeader = { "Your Donor's Form" }
        static let bloodGroupFallback = { "Will be updated on your first donation." }
    }
    
    struct Onboarding {
        struct CountySSN {
            static let countyDefaultValue = { "Please Select County" }
            static let title = { "Personal Details" }
            static let subtitle = { "We require some personal details from our donors in order to facilitate a proper donation experience." }
            static let county = { "County of Residence" }
            static let ssn = { "Your Social Security Number" }
        }
        
        struct BloodGroup {
            static let title = { "Blood Group" }
            static let subtitle = { "In order to match you with potential donors or people in need of blood, we need to know your blood group" }
            static let rh = { "Rh" }
            static let bloodGroup = { "Your Blood Group" }
            static let bloodGroupDefaultValue = { "Select Blood Group" }
        }
    }
    
    struct Login {
        static let validateAccountFirst = { "Firstly, validate your account by checking your mailbox." }
        static let emailPlaceholder = { "Email" }
        static let passwordPlaceholder = { "Password" }
        static let login = { "Log in" }
        static let noAccount = { "Don't have an account?" }
        static let signup = { "Sign up!" }
    }
    
    struct Signup {
        static let title = { "Account Details" }
        static let name = { "Name" }
        static let firstNamePlaceholder = { "Your first name" }
        static let lastNamePlaceholder = { "Your last name" }
        static let email = { "Email" }
        static let emailPlaceholder = { "Your personal email" }
        static let password = { "Password" }
        static let passwordPlaceholder = { "Enter password" }
        static let confirmPassword = { "Confirm Password" }
        static let confirmPasswordPlaceholder = { "Enter password again" }
        static let signup = { "Sign up" }
        static let haveAccount = { "Already have an account?" }
        static let login = { "Log in!" }
    }
    
    struct Misc {
        static let logout = { "Log out" }
        static let tryAgain = { "Try again" }
        static let cont = { "Continue" }
        static let done = { "Done" }
        static let skipForNow = { "Skip for now" }
    }
    
    struct Errors {
        static let serverUnreachable = { "Could not reach server." }
        static let serverError = { "Could not fetch server data." }
        static let generic = { "An error occured. Please try again." }
        
        struct Onboarding {
            static let invalidData = { "Invalid Data" }
        }
        
        struct Login {
            static let fieldsEmpty = { "Email or Password left empty!" }
            static let invalidEmail = { "Invalid email format!" }
        }
        
        struct Signup {
            static let allFieldsNeeded = { "All fields are compulsory!" }
            static let invalidEmail = { "Invalid email format!" }
            static let passNotMatch = { "Passwords do not match!" }
        }
    }
}
