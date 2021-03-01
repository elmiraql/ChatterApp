//
//  ViewController.swift
//  ChatterApp
//
//  Created by Elmira on 26.02.21.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var welcomeLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftButton.layer.cornerRadius = 35
        rightButton.layer.cornerRadius = 35
        welcomeLabel.text = Constants.appName
  }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}

