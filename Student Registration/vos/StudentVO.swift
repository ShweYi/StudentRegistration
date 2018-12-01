//
//  StudentVO.swift
//  Student Registration
//
//  Created by Shwe Yi Tun on 12/1/18.
//  Copyright © 2018 Shwe Yi Tun. All rights reserved.
//

import Foundation
import UIKit
class StudentVO: NSObject {
    
    var id : String = UUID.init().uuidString
    
    var username : String? = nil
    
    var email : String? = nil
    
    var phone : String? = nil
    
    var password : String? = nil
    
    var nrc : String? = nil
    
    var dob : String? = nil
    
    var fathername : String? = nil
    
    var image : String? = nil
    
    public static func parseToDictionary(user : StudentVO) -> [String : Any] {
        
        let value = [
            "id" : user.id,
            "username" : user.username ?? "",
            "email" : user.email ?? "",
            "phone" : user.phone ?? "",
            "password" : user.password ?? "",
            "nrc" : user.nrc ?? "",
            "dob" : user.dob ?? "",
            "fathername" : user.fathername ?? "",
            "image" : user.image ?? "",
        ]
        
        return value
        
    }
    
    public static func parseToUserVO(json : [String : Any]) -> StudentVO {
        
        let user = StudentVO()
        user.id = json["id"] as! String
        user.username = json["username"] as? String
        user.phone = json["phone"] as? String
        user.email = json["email"] as? String
        user.password = json["password"] as? String
        user.nrc = json["nrc"] as? String
        user.dob = json["dob"] as? String
        user.fathername = json["fathername"] as? String
        user.image = json["image"] as? String
        return user
        
    }
    
}
