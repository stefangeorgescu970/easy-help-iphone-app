//
//  Strings.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 14/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

struct Strings {
    struct SideBar {
        static let myProfile = { "My Profile" }
        static let myCourses = { "Courses" }
        static let previousCourses = { "Previous Courses" }
        struct Professor {
            static let addAttendance = { "Add Attendance" }
        }
        
        struct Student {
            static let myQRCode = { "My QR Code" }
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
        static let emailPlaceholder = { "Your university email" }
        static let password = { "Password" }
        static let passwordPlaceholder = { "Enter password" }
        static let confirmPassword = { "Confirm Password" }
        static let confirmPasswordPlaceholder = { "Enter password again" }
        static let signup = { "Sign up" }
        static let haveAccount = { "Already have an account?" }
        static let login = { "Log in!" }
    }
    
    struct Courses {
        static let title = { "Courses" }
        static let myCourses = { "My Courses" }
        static let partnerCourses = { "Partner Courses" }
        static let noCourses = { "No Courses to Display." }
        static let studentCurrentCourses = { "Current Courses" }
        static let studentPreviousCourses = { "Previous Courses" }
        static let noClasses = { "No Classes to Display." }
    }
    
    struct CourseDetails {
        static let attendanceRequired = { "attendance required" }
        static let details = { "Details" }
        static let students = { "Students" }
        static let noStudents = { "No students enrolled at this course." }
        static let grading = { "Grading" }
        static let noGradeHeader = { "Owner has not set grade header." }
        static let attendance = { "Attendance" }
        static let noAttendanceHeader = { "Owner has not set grade header." }
        static let year = { "Year" }
        static let academicId = { "Academic ID" }
        static let credits = { "ECTS" }
        static let owner = { "Owner" }
        static let professors = { "Professors" }
        static let associates = { "Associates" }
        static let noAssociates = { "No associates for this course" }
        static let myDetails = { "My Details" }
    }
    
    struct StudentDetails {
        static let title = { "Student Details" }
        static let studentTitle = { "My Details" }
        static let name = { "Name" }
        static let group = { "Group" }
        static let grades = { "Grades" }
        static let attendances = { "Attendances" }
        static let contactStudent = { "Contact Student" }
        static let attended = { "attended" }
        static let year = { "Year" }
        static let notSet = { "Value not set" }
        static let faculty = { "Faculty" }
        static let lineOfStudy = { "Line of Study" }
        static let department = { "Department" }
    }
    
    struct ProfileView {
        static let title = { "Settings" }
        static let faq = { "Frequently Asked Questions" }
        static let termsConds = { "Terms and Conditions" }
        
        struct Professor {
            static let subtitle = { "Professor at Babes-Bolyai University" }
        }
        
        struct Student {
            static let subtitle = { "Student at Babes-Bolyai University" }
        }
    }
    
    struct Misc {
        static let logout = { "Log out" }
        static let tryAgain = { "Try again" }
    }
    
    struct Languages {
        static let english = { "English" }
        static let romanian = { "Romanian" }
        static let magyar = { "Magyar" }
        static let german = { "German" }
    }
    
    struct Department {
        static let mathematics = { "Mathematics" }
        static let computerScience = { "Computer Science" }
        static let mathematicsAndComputerScience = { "Mathematics and Computer Science" }
    }
    
    struct Faculty {
        static let mathematicsAndComputerScience = { "Mathematics and Computer Science" }
    }
    
    struct Errors {
        static let serverUnreachable = { "Could not reach server." }
        static let serverError = { "Could not fetch server data." }
        static let generic = { "An error occured. Please try again." }
        
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
    
    struct AddAttendances {
        static let openCamera = { "Open Camera" }
        static let reviewStudents = { "Review Students" }
        static let finish = { "Finish" }
        static let title = { "Add Attendances" }
        
        static let firstInstruction = { "First, open camera for scanning." }
        static let secondInstruction = { "Then, review the list once you're done." }
        static let thirdInstruction = { "Finally, publish the data." }
    }
}
