//
//  HouseModel.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/20/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import Foundation

class HouseModel{
    
    let address1 : String
    let address2: String
    let size : Double
    let buildingSize: Double
    let price: Double
    let details: String
    let bedrooms: Int
    let bathrooms: Int
    let garage: Int
    let security: Bool
    let picture: NSData //Revisar tipo y conversion para pasar a base
    
    init(Address1: String, Address2: String, Size: Double, BuildingSize: Double, Price: Double, Details: String, Bedrooms: Int, Bathrooms: Int, Garage: Int, Security: Bool, Picture: NSData) {
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
        picture = Picture
    }
    
}
