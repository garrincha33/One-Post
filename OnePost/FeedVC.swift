//
//  FeedVC.swift
//  OnePost
//
//  Created by Richard Price on 15/11/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
        
        let keyChainResult = KeychainWrapper.defaultKeychainWrapper().removeObjectForKey(KEY_UID)
        print("Rich: ID Removed From Keychain \(keyChainResult)")
        dismiss(animated: true, completion: nil)
 
    }

}
