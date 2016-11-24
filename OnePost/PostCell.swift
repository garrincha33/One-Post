//
//  PostCell.swift
//  OnePost
//
//  Created by Richard Price on 16/11/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var profileImage:UIImageView!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var timeAgoLbl: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    @IBOutlet weak var commentsImg: UIImageView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var makePostImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesNumberLbl: UILabel!
    @IBOutlet weak var commentsLbl: UILabel!
    
    var post: Post!
    var likesRef: FIRDatabaseReference!
    var currentUser: FIRDatabaseReference!
    var printUser = ""
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likesImg.addGestureRecognizer(tap)
        likesImg.isUserInteractionEnabled = true

    }
    
    func configureCell(post: Post, img: UIImage?) {

        self.post = post
        
        likesRef = DataService.ds.REF_CURRENT_USER.child("likes").child(post.postKey)
        
        //get current user-----------        
        currentUser = DataService.ds.REF_CURRENT_USER
        
        currentUser.observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                self.printUser = (dictionary["username"] as? String)!
                
                print("your user is \(self.printUser)")
            }
            
        })
        //-----------------------------------
        
        self.caption.text = post.caption
        self.likesNumberLbl.text = "\(post.likes)"
        self.usernameLbl.text = post.username
        self.commentsLbl.text = post.comments
        
        
        if img != nil {
            
            self.postImg.image = img
            
        } else {
            
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, erorr) in
            
                if erorr != nil {
                    
                    print("RICH: unable to download image from firebase storage")
                    
                } else {
                    
                    print("Rich: image downloaded from firebase storage \(self.printUser)")
                    
                    
                    if let imgData = data {
                        
                        if let img = UIImage(data: imgData) {
                            
                            self.postImg.image = img
                            
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                            
                            
                        }
                        
                    }
                    
                }
                
            })
   
        }
        
        likesRef.observeSingleEvent(of: .value, with: {(snapshot) in
          
            if let _ = snapshot.value as? NSNull {
                
                self.likesImg.image = UIImage(named: "likes")
                
            } else {
                
                self.likesImg.image = UIImage(named: "likesfill")
                
            }
            
            
            
        })

    }
    
    func likeTapped(sender: UITapGestureRecognizer) {
        
        likesRef.observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                
                self.likesImg.image = UIImage(named: "likes")
                self.post.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
                
            } else {
                
                self.likesImg.image = UIImage(named: "likesfill")
                self.post.adjustLikes(addLike: false)
                self.likesRef.removeValue()
            }
            
            
        })
        
        
    }

}
