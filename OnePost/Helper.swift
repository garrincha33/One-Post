//
//  Helper.swift
//  OnePost
//
//  Created by Richard Price on 27/11/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Helper {

    static let helper = Helper()
    
    func getCurrentUser( getUser: String, currentUser: FIRDatabaseReference) {
        
        var currentUser = currentUser
        var getUser = getUser
        
        currentUser = DataService.ds.REF_CURRENT_USER
        
        currentUser.observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                getUser = (dictionary["username"] as? String)!
                
                print("your user is \(getUser)")
            }
            
        })
        
    }
    
    
    
    
}
