//
//  UserModel.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/20/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import Foundation

class UserModel{
    
    let name : String
    let lastname: String
    let email : String
    let phone: String
    let password: String
    let profile: NSData //Revisar tipo y conversion para pasar a base
    
    init(Name: String, LastName: String, Email: String, Phone: String, Password: String, Profile: NSData) {
        name = Name
        lastname = LastName
        email = Email
        phone = Phone
        password = Password
        profile = Profile
    }
    
}
