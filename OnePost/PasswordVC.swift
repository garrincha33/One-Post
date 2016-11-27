//
//  PasswordVC.swift
//  OnePost
//
//  Created by Richard Price on 24/11/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import UIKit
import Firebase

class PasswordVC: UIViewController {
    
    
    @IBOutlet weak var pwdtextField: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
   

    }
    
    @IBAction func pwdBtnPressed(_ sender: Any) {
        
        guard let email = pwdtextField.text, !email.isEmpty else {
            
            print("The email field needs to be populated")
            return
            
        }
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: self.pwdtextField.text!, completion: { (error) in
            
            if error != nil {
                
                print("there was an error \(error?.localizedDescription)")
                
            } else {
                
                print("reset password was a success, please check your email")
                self.pwdtextField.text = ""
                
            }
            
            
        })

    }

}
