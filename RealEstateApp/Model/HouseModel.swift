//
//  HouseModel.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/20/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import Foundation

class HouseModel{
    
    let id: Int
    let address1 : String
    let address2: String
    let size : Double
    let buildingSize: Double
    let price: String
    let details: String
    let bedrooms: Int
    let bathrooms: Int
    let garage: Int
    let security: Bool
    var isFavorite: Bool
    let pictures: [String]
    
    init(Id: Int, Address1: String, Address2: String, Size: Double, BuildingSize: Double, Price: String, Details: String, Bedrooms: Int, Bathrooms: Int, Garage: Int, Security: Bool, IsFavorite: Bool, Pictures: [String]) {
        id = Id
        address1 = Address1
        address2 = Address2
        size = Size
        buildingSize = BuildingSize
        price = Price
        details = Details
        bedrooms = Bedrooms
        bathrooms = Bathrooms
        garage = Garage
        security = Security
        isFavorite = IsFavorite
        pictures = Pictures
    }
    
    func changeFavorite(){
        if isFavorite {
            isFavorite = false
        }else{
            isFavorite = true
        }
    }
    
}
