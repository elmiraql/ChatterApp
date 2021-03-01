//
//  Constants.swift
//  ChatterApp
//
//  Created by Elmira on 28.02.21.
//

import Foundation

struct Constants {
    static let appName = "Welcome"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let cellidentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct Firestore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
