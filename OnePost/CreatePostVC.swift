//
//  CreatePostVC.swift
//  OnePost
//
//  Created by Richard Price on 17/11/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var cancelPost: UIImageView!
    
    @IBOutlet weak var makePost: UITextField!
    
    @IBOutlet weak var addImg: UIImageView!
  //  let nsDict = dict as! NSDictionary
 var userDict = [String:AnyObject]()
   
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    //get current user-------
    var currentUser: FIRDatabaseReference!
    var printUser = ""
    //----------------
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
  
    }

    @IBAction func postBtnPressed(_ sender: Any) {
        
        guard let makePostTxtField = makePost.text, !makePostTxtField.isEmpty else
        {
            print("Please enter a post")
            return
        }
        
        guard let img = addImg.image, imageSelected == true else {
            
            print("no image has been selected")
            return
            
        }
        //get current user-----------
        currentUser = DataService.ds.REF_CURRENT_USER
        currentUser.observe(FIRDataEventType.value, with: { (snapshot) in
   // currentUser.observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.printUser = (dictionary["username"] as? String)!
                self.userDict = dictionary
               
                print("your user is \(self.printUser)")
            }
        })
        //-----------------------------------
        if let imgData = UIImageJPEGRepresentation(img, 2.0) {
            
        let imgUid = NSUUID().uuidString
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imgUid).put(imgData, metadata: metadata)
            { (metadata, error) in
          
              
                var minSeconds : NSInteger
                   minSeconds=86400;
               
                var lastPostTime : Date
                var presentPostTime : Date
               
                
                if error != nil{
                    print("RICH: Unable to upload images to firebase Storage")
                }else
                {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd MMM yyy HH:mm"
                    let name = self.userDict["lastPostTime"] as? String
                    
                    presentPostTime = Date()
                    if self.userDict["lastPostTime"] != nil
                    {
lastPostTime = dateFormatter.date(from:name!)!
                       let interval = presentPostTime.timeIntervalSince(lastPostTime)
                        let i = Int(interval)

                        if i>=minSeconds
                        {
                            lastPostTime = presentPostTime
                            let downloadURL = metadata?.downloadURL()?.absoluteString
                            if let url = downloadURL
                            {
                                self.userDict["lastPostTime"]=dateFormatter.string(from: lastPostTime) as AnyObject?;
                                self.postToFirebase(imgUrl: url)
                                print("RICH: succesfully uploaded to Firebase Storage")
                            }
                        }
                        else{
                            print("RICH: User posted less than 24 hrs ago.")
                            }
                    }
                    else
                    {
                       
                        lastPostTime = presentPostTime
                                   let downloadURL = metadata?.downloadURL()?.absoluteString;                        if let url = downloadURL
                        {
                            self.userDict["lastPostTime"]=dateFormatter.string(from: lastPostTime) as AnyObject?;
                            self.postToFirebase(imgUrl: url)
                            print("RICH: succesfully uploaded to Firebase Storage")
                        }
                    }
                }
            }
        }
    }
    
    func postToFirebase(imgUrl: String) {
        
        let post: Dictionary<String, Any> =
            [
            "caption": makePost.text! as String,
            "imageURL": imgUrl as String,
            "likes": 0 as Int,
            "username" : printUser as String
            ]
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        currentUser.setValue(userDict)
        makePost.text = ""
        imageSelected = false
        addImg.image = UIImage(named: "add-image")
    }

    @IBAction func cancelBtnPressed(_ sender: Any)
    {
             dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            addImg.image = image
            imageSelected = true
            
            
        } else {
            
            print("RICH: a valid image wasnt selected")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addImgTapped(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }

}
