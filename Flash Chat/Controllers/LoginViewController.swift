//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Atakan Çavuşlu on 29/06/2020.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    @IBAction func loginPressed(_ sender: UIButton) {
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
            if let e = error {
                // Handle errors
                self.errorLabel.text = e.localizedDescription
            } else {
                // Navigate to the ChatViewController
                self.performSegue(withIdentifier: K.loginSegue, sender: self)
            }
            
        }
        
    }
    
}
