//
//  FriendVO.swift
//  ios
//
//  Created by 장상현 on 2017. 11. 3..
//  Copyright © 2017년 jex. All rights reserved.
//

import UIKit

//
class FriendVO: NSObject, NSCoding {
    var name: String?
    var title: String?
    var first: String?
    var last: String?
    var email: String?
    var cell: String?
    var picture: String?
    var nat: String?

    override init(){
        name = ""
        title = ""
        first = ""
        last = ""
        email = ""
        cell = ""
        picture = ""
        nat = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.first = aDecoder.decodeObject(forKey: "first") as? String
        self.last = aDecoder.decodeObject(forKey: "last") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.cell = aDecoder.decodeObject(forKey: "cell") as? String
        self.picture = aDecoder.decodeObject(forKey: "picture") as? String
        self.nat = aDecoder.decodeObject(forKey: "nat") as? String
        
    }
    

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.first, forKey: "fisrt")
        aCoder.encode(self.last, forKey: "last")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.cell, forKey: "cell")
        aCoder.encode(self.picture, forKey: "picture")
        aCoder.encode(self.nat, forKey: "nat")
    }
}
