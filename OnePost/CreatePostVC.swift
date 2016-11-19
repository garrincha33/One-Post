//
//  CreatePostVC.swift
//  OnePost
//
//  Created by Richard Price on 17/11/2016.
//  Copyright © 2016 twisted echo. All rights reserved.
//

import UIKit

class CreatePostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var cancelPost: UIImageView!
    
    @IBOutlet weak var makePost: UITextField!
    
    @IBOutlet weak var addImg: UIImageView!
    
    var imagePicker: UIImagePickerController!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        

    }

    @IBAction func postBtnPressed(_ sender: Any) {
        
        
        
        
        
        
    }
    
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
     
        dismiss(animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            addImg.image = image
            
            
        } else {
            
            print("RICH: a valid image wasnt selected")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addImgTapped(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
   


}
