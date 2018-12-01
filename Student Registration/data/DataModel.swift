//
//  DataModel.swift
//  Student Registration
//
//  Created by Shwe Yi Tun on 12/1/18.
//  Copyright © 2018 Shwe Yi Tun. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataModel {
    private init() {}
    var user : StudentVO? = nil
    
    static var shared : DataModel = {
        return sharedDataModel
    }()
    
    private static var sharedDataModel: DataModel = {
        let dataModel = DataModel()
        return dataModel
    }()

    func uploadImage(data : Data?, success : @escaping (String) -> Void, failure : @escaping () -> Void) {
        
        NetworkManager.shared.imageUpload(data: data, success: { (url) in
            success(url)
        }) {
            failure()
        }
        
    }
    
    func register(user : StudentVO, success : @escaping () -> Void) {
        
        let ref = Database.database().reference()
        ref.child("users").child(user.id).setValue(StudentVO.parseToDictionary(user: user))
        success()
        
    }
    
    func login(email : String, password : String, success : @escaping () -> Void, failure : @escaping () -> Void) {
        
        NetworkManager.shared.login(email: email, password: password, success: { (user) in
            
            self.user = user
            success()
            
        }) {
            failure()
        }
        
    }
    
    func getStudent(success : @escaping ([StudentVO]) -> Void, failure : @escaping () -> Void) {
        
        NetworkManager.shared.loadStudents(success: { (data) in
            
            success(data)
            
        }, failure: {
            failure()
        })
        
    }
    
}
