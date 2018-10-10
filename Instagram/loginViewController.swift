//
//  loginViewController.swift
//  Instagram
//
//  Created by Joseph Andy Feidje on 10/8/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit
import Parse


class loginViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var SignIN: UIButton!
    @IBOutlet weak var SignUP: UIButton!
    
    var generalError = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SignIN.layer.cornerRadius = 5
        SignIN.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnSignIn(_ sender: Any) {
        userSignIn()
    }
    
    @IBAction func OnSignUP(_ sender: Any) {
        userSignUp()
    }
    
    func userSignIn() {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("Logged in Successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                print(error?.localizedDescription)
                self.generalError = (error?.localizedDescription)!
                self.generalAlert()
            }
            }
    }
    
    func userSignUp() {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text

        newUser.signUpInBackground { (success: Bool, error: Error?) in
            
            if success {
                print("Yes,User Created successfully!")
                //                                // manually segue to logged in view
            }
            else{
                print(error?.localizedDescription)
                self.generalError = (error?.localizedDescription)!
                self.generalAlert()
            }

            }
    }
    
    func EmptyFieldAlert() -> Bool {
        var isFieldEmpty = false
        if usernameField.text?.isEmpty == true || passwordField.text?.isEmpty == true{
            isFieldEmpty = true
            let alertController = UIAlertController(title: "TextField Empty", message: "This Field can't be Empty.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default
                , handler: { (action) in self.userSignUp()}))
            self.present(alertController, animated: true)
            
        }
        return isFieldEmpty;
    }
    
    func networkErrorAlert(){
        let alertController = UIAlertController(title: "Network Error", message: "It's Seems there is a network error. Please try again later.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { (action) in self.userSignUp()}))
        self.present(alertController, animated: true)
    }
    
    func generalAlert(){
        let alertController = UIAlertController(title: "Alert", message: self.generalError , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in self}))
        self.present(alertController, animated: true)
    }
    
}
