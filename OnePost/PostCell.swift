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
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configureCell(post: Post, img: UIImage?) {
        
        self.post = post
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
                    
                    print("Rich: image downloaded from firebase storage")
                    
                    if let imgData = data {
                        
                        if let img = UIImage(data: imgData) {
                            
                            self.postImg.image = img
                            
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                            
                            
                        }
                        
                    }
                    
                }
                
            })
            
        }

    }

}
