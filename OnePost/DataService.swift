//
//  DataService.swift
//  OnePost
//
//  Created by Richard Price on 17/11/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_URL = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_POST_IMAGES = STORGE_BASE.child("post-pics")
    
    var REF_BASE: FIRDatabaseReference {
        
        return _REF_URL
        
    }
    
    var REF_POSTS: FIRDatabaseReference {
        
        return _REF_POSTS
        
    }
    
    var REF_USERS: FIRDatabaseReference {
        
        return _REF_USERS
        
    }
    
    var REF_CURRENT_USER: FIRDatabaseReference {
        
        let uid = KeychainWrapper.defaultKeychainWrapper().stringForKey(KEY_UID)
    
        let user = REF_USERS.child(uid!)
        
        return user
        
    }
    
    var REF_POST_IMAGES: FIRStorageReference {
        
        return _REF_POST_IMAGES
        
    }
 
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    

}
