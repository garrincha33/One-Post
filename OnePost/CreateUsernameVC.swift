//
//  CreateUsernameVC.swift
//  OnePost
//
//  Created by Richard Price on 24/11/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import UIKit
import Firebase

class CreateUsernameVC: UIViewController {
    
    
    @IBOutlet weak var enterUsernameTxtField: UITextField!
    
    //get current user-------
    var currentUser: FIRDatabaseReference!
    var printUser = ""
    //----------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    
    @IBAction func submitUsernamePressed(_ sender: Any) {
        
        guard let username = enterUsernameTxtField.text, !username.isEmpty else {
            
            print("a username needs to be entered....")
            
            return
            
        }
   
        //get current user-----------
        currentUser = DataService.ds.REF_CURRENT_USER
        
        currentUser.observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                self.printUser = (dictionary["username"] as? String)!
                
                print("your user is \(self.printUser)")
            }
            
        })
        //-----------------------------------

        DataService.ds.changeUsername(username: username)
        
        dismiss(animated: true, completion: nil)

        currentUser.child("username").setValue(username)
    }

}
