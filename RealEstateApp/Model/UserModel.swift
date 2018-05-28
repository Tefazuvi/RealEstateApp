//
//  UserModel.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/20/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import Foundation

class UserModel: Codable{
    
    let idUser: Int
    let name : String?
    let lastname: String?
    let email : String
    let password: String
    let phone: String?
    let type: Int?
    let profile: String? //Revisar tipo y conversion para pasar a base
    
    init(Id: Int, Name: String?, LastName: String?, Email: String,Password: String, Phone: String?, Type: Int, Profile: String?) {
        idUser = Id
        name = Name
        lastname = LastName
        email = Email
        password = Password
        phone = Phone
        type = Type
        profile = Profile
    }    
}
