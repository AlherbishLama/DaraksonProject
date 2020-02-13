//
//  currentUser.swift
//  Home
//
//  Created by Lama Alherbish on 08/02/2020.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import Foundation

struct currentUser {
    let uid: String
    let CarName: String
    let ChildAge: String
    let ChildName: String
    let FavoriteHobby: String
    let email: String
    
    init(uid: String , dictionary: [String:Any]) {
        self.uid = uid
        self.CarName = dictionary["CarName"] as? String ?? ""
        self.ChildAge = dictionary["ChildAge"] as? String ?? ""
        self.ChildName = dictionary["ChildName"] as? String ?? ""
        self.FavoriteHobby = dictionary["FavoriteHobby"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}
