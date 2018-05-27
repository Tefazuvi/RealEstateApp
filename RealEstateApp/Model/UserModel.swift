//
//  UserModel.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/20/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import Foundation

class UserModel: Codable{
    
    //let id: Int
    let name : String
    let lastname: String
    let email : String
    let password: String
    let phone: String
    let type: Int
    //let profile: NSData //Revisar tipo y conversion para pasar a base
    
    init(Name: String, LastName: String, Email: String,Password: String, Phone: String, Type: Int) {
        name = Name
        lastname = LastName
        email = Email
        password = Password
        phone = Phone
        type = Type
        //profile = Profile
    }
    /*
     func getJSON()-> String{
     let jsonEncoder = JSONEncoder()
     let jsonData = try! jsonEncoder.encode(self)
     let json = String(data: jsonData, encoding: String.Encoding.utf8)
     
     //PRUEBA
     print(json!)
     return json!
     }*/
    
}
