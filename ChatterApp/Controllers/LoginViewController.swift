//
//  LoginViewController.swift
//  ChatterApp
//
//  Created by Elmira on 27.02.21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        signInButton.layer.cornerRadius = 35
    }
    
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        if let email = userNameTextField.text, let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                     //guard let strongSelf = self else { return }
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                }
            }
        }
       
    }
}
