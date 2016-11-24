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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    var currentUser = ""
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        DataService.ds.REF_POSTS.observe(.value, with: {(snapshot) in

            self.posts = []
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snaps in snapshot {
                    
                    print("SNAP----: \(snaps)")
                    
                    if let postDict = snaps.value as? Dictionary<String, AnyObject> {
                        
                        let key = snaps.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        
                    }
                    
                }
                
            }
            
            self.tableView.reloadData()

        })

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: POST_CELL) as? PostCell {
            
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                
                cell.configureCell(post: post, img: img)
                
                return cell
                
            } else {
                
                cell.configureCell(post: post, img: nil )
                
                return cell
            }
       
        } else {
            
            return PostCell()
            
        }
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return posts.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
        
       let keyChainResult = KeychainWrapper.defaultKeychainWrapper().removeObjectForKey(KEY_UID)
        print("RICH: removed from keychain \(keyChainResult)")
        try! FIRAuth.auth()?.signOut()
        dismiss(animated: true, completion: nil)
  
    }

}
