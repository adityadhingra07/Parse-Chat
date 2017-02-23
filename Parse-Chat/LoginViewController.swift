//
//  ViewController.swift
//  Parse-Chat
//
//  Created by Aditya Dhingra on 2/21/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func signUp(_ sender: UIButton) {
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground {
            (success, error) -> Void in
            if let error = error {
                if ((error as NSError).userInfo["error"] as? String) != nil {
                    print("Error Couldn't login!")
                    let alert = UIAlertController(title: "Error", message: "Error Signing Up!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                // Hooray! Let them use the app now.
                print("Signed up!");
                
            }
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        let user = PFUser()
        let username = emailTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user: PFUser?, error: Error?) -> Void in
            if let error = error {
                if ((error as NSError).userInfo["error"] as? String) != nil {
                    let alert = UIAlertController(title: "Error", message: "Error Loging In!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                // Hooray! Let them use the app now.
                NSLog("Logged in!");
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

