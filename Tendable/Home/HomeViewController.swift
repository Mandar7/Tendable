//
//  ViewController.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 15/06/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    var loginVc = LoginViewController()

    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: IBActions
    @IBAction func loginButtonAction(_ sender: Any) {
        self.loginVc.isRegister = false
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        self.loginVc.isRegister = true
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
}

