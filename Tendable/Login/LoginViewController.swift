//
//  LoginViewController.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 15/06/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    // IBOutlets/Constants
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var emailIdTxtFld: UITextField!
    @IBOutlet var passwordTxtFld: UITextField!
    @IBOutlet var loginBtn: UIButton!
    var isRegister: Bool = false
    var viewModel = RegisterViewModel()
    let dashboardVC = DashboardViewController()

    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initialSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.emailIdTxtFld.text = ""
        self.passwordTxtFld.text = ""
    }

    // MARK: Setup Methods
    func initialSetup() {
        self.titleLable.text = isRegister ? REGISTER : LOGIN
        self.loginBtn.setTitle(isRegister ? REGISTER : LOGIN, for: .normal)
    }

    // MARK: IBActions
    @IBAction func loginBtnAction(_ sender: Any) {
        if !isValid() {
            presentAlert(title: ERROR, message: EMAIL_PASSWORD_ERROR_MSG)
            return
        }
        isRegister ? self.doRegisteration() : self.doLogin()
    }

    // MARK: Helper Methods
    func isValid() -> Bool {
        if let emailId = emailIdTxtFld.text, let password = passwordTxtFld.text {
            return (!emailId.isEmpty && !password.isEmpty)
        }
        return false
    }
}

// MARK: API Handlings
extension LoginViewController {
    
    func doRegisteration() {
        viewModel.registerUser(emaiId: emailIdTxtFld.text ?? "", password: passwordTxtFld.text ?? "") { [weak self] (success, message) in
            DispatchQueue.main.async {
                if success {
                    self?.presentAlert(title: SUCCESS, message: REG_SUCCESS_MSG, completion: {
                        self?.navigationController?.popViewController(animated: true)
                    })
                } else {
                    self?.presentAlert(title: FAILURE, message: message)
                }
            }
        }
    }
    
    func doLogin() {
        viewModel.loginUser(emaiId: emailIdTxtFld.text ?? "", password: passwordTxtFld.text ?? "") { [weak self] (success, message) in
            DispatchQueue.main.async {
                if success {
                    if let dashboardVC = self?.dashboardVC {
                        self?.presentAlert(title: SUCCESS, message: LOGIN_SUCCESS_MSG, completion: {
                            self?.navigationController?.pushViewController(dashboardVC, animated: true)
                        })
                    }
                } else {
                    self?.presentAlert(title: FAILURE, message: message)
                }
            }
        }
    }
}
