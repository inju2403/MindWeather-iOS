//
//  SignUpViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import UIKit

import Alamofire

class SignUpViewController : UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordVerificationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordVerificationTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 네비게이션 컨트롤러 루트에서만 스와이프가 안먹히게 함
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (self.navigationController?.viewControllers.count)! > 1
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func personalInformationProcessingButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.personalInformationProcessingSegue, sender: self)
    }
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        guard let username = usernameTextField.text,
             let email = emailTextField.text,
             let password1 = passwordTextField.text,
             let password2 = passwordVerificationTextField.text else {
            return
        }
        
        if username == "" {
            self.showAlert(style: .alert, message: "닉네임을 입력해주세요", type: "failure")
        } else if isValidEmail(email: email) == false {
            showAlert(style: .alert, message: "이메일 형식을 확인해주세요", type: "failure")
        } else if password1 != password2 {
            showAlert(style: .alert, message: "비밀번호가 일치하지 않아요", type: "failure")
        } else if isValidPassword(password: password1) == false {
            showAlert(style: .alert, message: "비밀번호는 영문, 숫자, 특수문자를 조합해서 만들어 주세요", type: "failure")
        } else {
            let signUpRequest = SignUpRequest(username: username, email: email, password1: password1, password2: password2)
            
            AF.request("\(Constant.APIBaseUrl)auth/registration/",
                       method: .post,
                       parameters: signUpRequest,
                       encoder: JSONParameterEncoder())
                    .responseDecodable(of: SignUpRequest.self) { response in
                        debugPrint(response)
                        switch response.response?.statusCode {
                        case 201:
                            print("회원가입 성공")
                            self.showAlert(style: .alert, message: "회원가입 성공", type: "success")
                            break
                        case 400:
                            self.showAlert(style: .alert, message: "닉네임 혹은 이메일이 이미 존재해요", type: "failure")
                            print("error")
                            break
                        default:
                            break
                        }
                        
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
        
        // 네비게이션 바 숨김
        self.navigationController?.isNavigationBarHidden = true
        // 네비게이션 바를 숨기면서 스와이프 동작이 가능하게 함
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func isValidEmail(email: String) -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailTest.evaluate(with: email)
   }
    
    func isValidPassword(password : String) -> Bool {
        //영문+숫자+특수문자 포함해서 8~50글자 사이의 text 체크하는 정규표현식
        let passwordreg = ("^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: password)
    }

    
    func showAlert(style: UIAlertController.Style, message: String, type: String) {
        let titleFont = [NSAttributedString.Key.font: UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)]
        let titleAttrString = NSMutableAttributedString(string: message, attributes: titleFont)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: style)
        alert.setValue(titleAttrString, forKey:"attributedTitle")
        
        let success = UIAlertAction(title: "확인", style: .default, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        })
        success.setValue(UIColor(rgb: Constant.brownColor), forKey: "titleTextColor")
        
        let failure = UIAlertAction(title: "확인", style: .default, handler: nil)
        failure.setValue(UIColor(rgb: Constant.brownColor), forKey: "titleTextColor")
        
        if type == "success" {
            alert.addAction(success)
        } else if type == "failure" {
            alert.addAction(failure)
        }
        
        self.present(alert, animated: true, completion: nil)
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

//extension SignUpViewController: UINavigationControllerDelegate {
//
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = navigationController.viewControllers.count > 1
//    }
//}
