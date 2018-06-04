//
//  ContactAgent.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 6/3/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import Foundation

class ContactAgent{
    
    let idContact: Int
    let name : String
    let lastname: String
    let email : String
    let phone: String
    let profile: String //Revisar tipo y conversion para pasar a base
    
    init(Id: Int, Name: String, LastName: String, Email: String, Phone: String, Profile: String) {
        idContact = Id
        name = Name
        lastname = LastName
        email = Email
        phone = Phone
        profile = Profile
    }
}
