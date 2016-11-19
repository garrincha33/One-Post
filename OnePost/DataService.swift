//
//  DataService.swift
//  OnePost
//
//  Created by Richard Price on 17/11/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_URL = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
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
        
        let user = _REF_USERS.child("username")
        
        return user
        
    }
    
    
    
    
    
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
