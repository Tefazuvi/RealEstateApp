//
//  FavoriteModel.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 6/3/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteModel: Object{
    
    @objc dynamic var comments: String? = nil
    @objc dynamic var idHouse: Int = 0
    
    static func saveFavorite(idHome: Int, userComments: String?){
        
        let favorite = FavoriteModel()
        favorite.comments = userComments
        favorite.idHouse = idHome
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(favorite)
        }
        
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    static func updateComments(id: Int, UserComments: String?){
        
        let realm = try! Realm()
        let favorites = realm.objects(FavoriteModel.self).filter("idHouse = \(id)")
        
        if favorites.count > 0 {
            if let favorite = favorites.first
            {
                try! realm.write {
                    favorite.comments = UserComments
                }
            }
        }
        
    }
    
    static func deleteFavorite(id: Int){
        
        let realm = try! Realm()
        let favorites = realm.objects(FavoriteModel.self).filter("idHouse = \(id)")
        
        try! realm.write {
            if let favorite = favorites.first {
                realm.delete(favorite)
            }
        }
        
    }
    
    static func getAllFavorites() -> [FavoriteModel]{
        
        let realm = try! Realm()
        let favorites = realm.objects(FavoriteModel.self)
        
        let array = Array(favorites)
        return array
    }
    
    static func countObjects()->Int{
        
        let realm = try! Realm()
        let favorites = realm.objects(FavoriteModel.self)
        
        return favorites.count
    }
}
