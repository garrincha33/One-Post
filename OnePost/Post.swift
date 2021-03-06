//
//  Post.swift
//  OnePost
//
//  Created by Richard Price on 17/11/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import Foundation

class Post {
    
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _comments: String!
    private var _postKey: String!
    //private var _username: String!
    
    
    var caption: String {
        
        return _caption
        
    }
    
    var imageUrl: String {
        
        return _imageUrl
        
    }
    
    var likes: Int {
        
        return _likes
        
    }
    
    var comments:String {
        
        return _comments
        
    }
    
    var postKey: String {
        
        return _postKey
        
    }
    
//    var username: String {
//        
//        return _username
//        
//    }
    
    init(caption: String, imageUrl: String, likes: Int, username: String) {
        
        //self._username = username
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
        
        
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            
            self._caption = caption
            
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            
            self._imageUrl = imageUrl
            
        }
        
        if let likes = postData["likes"] as? Int {
            
            self._likes = likes
            
        }
        
        if let comments = postData["comments"] as? String {
            
            self._comments = comments
            
        }
        
        
    }
    
    
    
    
    
}
