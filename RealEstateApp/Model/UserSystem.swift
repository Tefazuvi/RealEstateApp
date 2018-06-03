//
//  UserSystem.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 6/2/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import Foundation
import RealmSwift

class UserSystem: Object{
    
    @objc dynamic var idUser: Int = 0
    @objc dynamic var email : String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var remember: Bool = true
    
    static func saveUser(newUser : UserModel)->UserSystem{
        
        let NewUser = UserSystem()
        NewUser.idUser = newUser.idUser
        NewUser.email = newUser.email
        NewUser.password = newUser.password
        NewUser.remember = true
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(NewUser)
        }
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        return NewUser
    }
    
    static func getLast()-> UserSystem?{
        let realm = try! Realm()
        let users = realm.objects(UserSystem.self)
        if users.count > 0 {
            let user = users[users.count-1]
            return user
        }else{
            return nil
        }
    }
    
    static func updateUser(id: Int, rememberValue: Bool){
        let realm = try! Realm()
        let users = realm.objects(UserSystem.self).filter("idUser = \(id)")
        if users.count > 0 {
            let user = users[users.count-1]
            try! realm.write {
                user.remember = rememberValue
            }
        }
    }
    
    static func countObjectsandPrint(){
        let realm = try! Realm()
        
        let users = realm.objects(UserSystem.self)
        print(users.count)
    }
    
}
