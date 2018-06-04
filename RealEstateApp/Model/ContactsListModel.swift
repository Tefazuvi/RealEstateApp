//
//  ContactsListModel.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 6/3/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import Foundation

class ContactsListModel{
    
    var contactsList = [ContactAgent] ()
    
    init() {
        contactsList.append(ContactAgent(Id: 0, Name: "Darth", LastName: "Vader", Email: "jointhedarkside@gmail.com", Phone: "8000-0000", Profile: "agent2"))
        contactsList.append(ContactAgent(Id: 0, Name: "Donald", LastName: "Trump", Email: "idontwearwig@gmail.com", Phone: "8765-0000", Profile: "agent1"))
        contactsList.append(ContactAgent(Id: 0, Name: "Padme", LastName: "Amidala", Email: "iamtheprincess@gmail.com", Phone: "8888-0000", Profile: "agent3"))
    }
}
