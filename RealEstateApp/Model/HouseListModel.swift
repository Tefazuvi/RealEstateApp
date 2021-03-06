//
//  HouseListModel.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 6/2/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import Foundation

class HouseListModel{
    
    static let sharedInstance = HouseListModel()
    
    let agentsList = ContactsListModel()
    var houseList = [HouseModel] ()
    
    init() {
        houseList.append(HouseModel(Id: 0, Address1: "Moravia, Los Colegios.", Address2: "Residencial Montealondra Casa #24", Size: 300, BuildingSize: 200, Price: "100.000.000", Details: "Vende el dueño, residencial familiar.", Bedrooms: 2, Bathrooms: 2, Garage: 1, Security: true, IsFavorite: false, Pictures: ["home1-A","home1-B","home1-C","home1-D","home1-E","home1-F"], Contact:  agentsList.contactsList[0]))
        
        houseList.append(HouseModel(Id: 1, Address1: "Heredia, Santo Domingo.", Address2: "100 metros Oeste del Mac Donalds.", Size: 600, BuildingSize: 400, Price: "150.000.000", Details: "Casa con piscina y seguridad privada.", Bedrooms: 3, Bathrooms: 1, Garage: 2, Security: true, IsFavorite: false, Pictures: ["Home2-A","Home2-B","Home2-C","Home2-D","Home2-E","Home2-F"], Contact:  agentsList.contactsList[1]))
        
        houseList.append(HouseModel(Id: 2, Address1: "Tibas, La Alondra.", Address2: "50 metros Norte de Pricesmart, porton negro.", Size: 800, BuildingSize: 500, Price: "200.000.000", Details: "Vende el dueño, residencial familiar.", Bedrooms: 4, Bathrooms: 2, Garage: 3, Security: false, IsFavorite: false, Pictures: ["Home3-A","Home3-B","Home3-C","Home3-D","Home3-E","Home3-F"], Contact:  agentsList.contactsList[2]))
        
        houseList.append(HouseModel(Id: 3, Address1: "Guanacaste, Bagaces.", Address2: "Contiguo al bar El Unico", Size: 100, BuildingSize: 70, Price: "90.000.000", Details: "Vende el dueño, residencial familiar.", Bedrooms: 2, Bathrooms: 1, Garage: 0, Security: false, IsFavorite: false, Pictures: ["Home4-A","Home4-B","Home4-C","Home4-D","Home4-E"], Contact:  agentsList.contactsList[0]))
        
        houseList.append(HouseModel(Id: 4, Address1: "Santa Ana, Lindora.", Address2: "Residencial Valles del Sol Casa #30", Size: 1300, BuildingSize: 800, Price: "185.000.000", Details: "Casa Club, campo de golf y lago.", Bedrooms: 4, Bathrooms: 3, Garage: 4, Security: true, IsFavorite: false, Pictures: ["home5-A","home5-B","home5-C","home5-D"], Contact:  agentsList.contactsList[1]))
    }
}
