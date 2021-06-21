//
//  SignUpViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import UIKit
import Alamofire

class SignUpViewController : UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordVerificationTextField: UITextField!
    override func viewDidLoad() {
        
        setUI()
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordVerificationTextField.delegate = self
        super.viewDidLoad()
        
        
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
    
    // 사용자가 바로 입력할 수 있도록 세팅
    override func viewWillAppear(_ animated: Bool) {
        self.usernameTextField.becomeFirstResponder()
    }
    
    // 키보드 밖을 클릭하면 키보드가 내려가도록 세팅
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.usernameTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.passwordVerificationTextField.resignFirstResponder()
    }
    
    private func setUI() {
        usernameTextField.underlined()
        emailTextField.underlined()
        passwordTextField.underlined()
        passwordVerificationTextField.underlined()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordVerificationTextField.becomeFirstResponder()
        } else {
            passwordVerificationTextField.resignFirstResponder()
        }
        return true
    }
}
