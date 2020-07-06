//
//  Constants.swift
//  Flash Chat
//
//  Created by Atakan Çavuşlu on 7.07.2020.
//  Copyright © 2020 Atakan Çavuşlu. All rights reserved.
//

struct K {
    
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {

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
