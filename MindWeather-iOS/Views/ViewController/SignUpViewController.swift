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
        
        guard let username = usernameTextField.text,
             let email = emailTextField.text,
             let password1 = passwordTextField.text,
             let password2 = passwordVerificationTextField.text else {
            return
        }
        
        let signUpRequest = SignUpRequest(username: username, email: email, password1: password1, password2: password2)
        
        AF.request("\(K.API_BASE_URL)auth/registration/",
                   method: .post,
                   parameters: signUpRequest,
                   encoder: JSONParameterEncoder())
                .responseDecodable(of: SignUpRequest.self) { response in
                    debugPrint(response)
                    switch response.response?.statusCode {
                    case 201:
                        print("회원가입 성공")
                        self.dismiss(animated: true, completion: nil)
                        break
                    case 400:
                        print("error")
                        break
                    default:
                        break
                    }
                    
                }
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
