//
//  PostCell.swift
//  OnePost
//
//  Created by Richard Price on 16/11/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var profileImage:UIImageView!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var timeAgoLbl: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    @IBOutlet weak var commentsImg: UIImageView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var makePostImg: UIImageView!
    @IBOutlet weak var likesNumberLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }


}
