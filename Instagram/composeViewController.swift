//
//  composeViewController.swift
//  Instagram
//
//  Created by Joseph Andy Feidje on 10/9/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit

class composeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postPic: UIImageView!
    @IBOutlet weak var postDesc: UITextField!
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "loginSegue2", sender: nil)
    }
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        Post.postUserImage(image: postPic.image, withCaption: postDesc.text!) { (success, error) in
            if error != nil {
                print(error.debugDescription)
            }
            else{
                print("Posted Succeessfully")
                self.performSegue(withIdentifier: "loginSegue2", sender: nil)
            }
        }
    }
    
    @IBAction func didTapGesture(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    // Delegate Protocols
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        // let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        postPic.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

}
