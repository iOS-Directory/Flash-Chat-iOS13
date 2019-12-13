//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by FGT MAC on 12/13/19.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

//Creating a file to hold all the reference strings to prevent mistakes
struct K {
    
    //List of constants
    //The static keyword will allow us to refer to the variable as a data type
        static let appName = "⚡️FlashChat"
        static let cellIdentifier = "ReusableCell"
        static let cellNibName = "MessageCell"
        static let registerSegue = "RegisterToChat"
        static let loginSegue = "LoginToChat"
        
        struct BrandColors {
            static let purple = "BrandPurple"
            static let lightPurple = "BrandLightPurple"
            static let blue = "BrandBlue"
            static let lighBlue = "BrandLightBlue"
        }
        
        struct FStore {
            static let collectionName = "messages"
            static let senderField = "sender"
            static let bodyField = "body"
            static let dateField = "date"
        }
    }
