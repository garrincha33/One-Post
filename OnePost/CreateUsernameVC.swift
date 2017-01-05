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
    var allUsers: FIRDatabaseReference!
    var alluids = [String]()
    var allUsersArray = [String]()
    var printUser = ""
    //----------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func submitUsernamePressed(_ sender: Any)
    {
        // get all users
        allUsers =  DataService.ds.REF_USERS
        allUsers.observeSingleEvent(of: .value, with: {(snapshot) in
            var uidString = ""
            if let dict1 = snapshot.value as? [String: AnyObject] {
                self.alluids = [String] (dict1.keys)
                for index in 0..<self.alluids.count{
                    uidString=self.alluids[index]
                    let temp = dict1[String(format: "%@", uidString)] as? [String: AnyObject]
                    let checkString = temp!["username"] as? String
                    print("check String is \(checkString)")
                     if (checkString == nil)
                     {
                     }else
                     {
                        self.allUsersArray.append((checkString)!)
                     }
                }
                 print("array is \(self.allUsersArray)")
                if self.allUsersArray.contains(self.enterUsernameTxtField.text!)
                {
                    print("this username already exist....")
                    self.enterUsernameTxtField.text = ""
                }
                else
                {
                    guard let username = self.enterUsernameTxtField.text, !username.isEmpty else {
                        
                        print("a username needs to be entered....")
                        
                        return
                        
                    }
                    
                    //get current user-----------
                    self.currentUser = DataService.ds.REF_CURRENT_USER
                    
                    self.currentUser.observeSingleEvent(of: .value, with: {(snapshot) in
                        
                        if let dictionary = snapshot.value as? [String: AnyObject] {
                            
                            self.printUser = (dictionary["username"] as? String)!
                            
                            print("your user is \(self.printUser)")
                        }
                        
                    })
                    //-----------------------------------
                    DataService.ds.changeUsername(username: username)
                    
                   
                    
                    self.currentUser.child("username").setValue(username)
                }
            }
            
        })
        
        dismiss(animated: true, completion: nil)
    }
    
}
