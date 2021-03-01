//
//  RegisterViewController.swift
//  ChatterApp
//
//  Created by Elmira on 27.02.21.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        signUpButton.layer.cornerRadius = 35
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        if let email = userNameTextField.text,  let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            }
        }
    }
}
