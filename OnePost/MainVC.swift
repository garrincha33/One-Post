//
//  MainVC.swift
//  OnePost
//
//  Created by Richard Price on 10/11/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class MainVC: UIViewController {
    
    
    @IBOutlet weak var usernameLoginTxtField: UITextField!
    
    @IBOutlet weak var passwwordLoginTxtField: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboard()
       
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.defaultKeychainWrapper().stringForKey(KEY_UID) {
            
            print("ID Found in KeyChain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
            
        }
    }
    
    //------FOR FIREBASE IMPLEMENTATION
//    func firebaseAuth(_ credential: FIRAuthCredential) {
//        
//        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
//            
//            if error != nil {
//                
//                print("Rich: unable to auth with firebase")
//                
//            } else {
//                
//                print("Rich: Successfully authenticated with firebase")
//                
//                if let user =  user {
//                    
//                    let userData = ["provider" : credential.provider]
//                    self.completeSignIn(id: user.uid, userData: userData)
//                    
//                }
//                
//                
//            }
//            
//        })
//        
//    }
    
  
    @IBAction func loginBtn(_ sender: AnyObject) {
        
        guard let email = usernameLoginTxtField.text, !email.isEmpty else {
            
            print("The email field needs to be populated")
            return
        }
        
        guard let pwd = passwwordLoginTxtField.text, !pwd.isEmpty else {
            print("The password field needs to be populated")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
            
            if error == nil {
                
                print("Rich: EMAIL USER AUTHENTICATED\(error.debugDescription)")
                
                if let user = user {
                    
                    let userData = ["provider" : user.providerID]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
                
            } else {
                
                print("did we get here")
                
                FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                    
                    if error != nil {
                        
                        print("Rich: unable to authenticate with firebase \(error.debugDescription)")
                        
                    } else {
                        
                        print("RICH: successfully authenticated and added user to firebase....")
                        
                        if let user = user {
                            
                            let userData = ["provider" : user.providerID]
                            self.completeSignIn(id: user.uid, userData: userData)
                            
                        }
                    }
                    
                })
                
            }
            
        })
        
    }

    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)

        let keychainResult = KeychainWrapper.defaultKeychainWrapper().setString(id, forKey: KEY_UID)
        print("Rich: Data Saved to Keychain \(keychainResult)")
        performSegue(withIdentifier: USERNAME_VC, sender: nil)
        usernameLoginTxtField.text = ""
        passwwordLoginTxtField.text = ""
        
        
    }
    
    func hideKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainVC.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    
    
    func dismissKeyboard() {
        
        view.endEditing(true)
        
    }
        
    

}

