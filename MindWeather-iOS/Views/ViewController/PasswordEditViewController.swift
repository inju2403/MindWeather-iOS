//
//  PasswordEditViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/07/03.
//

import UIKit
import Alamofire

class PasswordEditViewController: UIViewController {
    
    let token = "JWT " + UserDefaults.standard.string(forKey: "token")!
    
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField1: UITextField!
    @IBOutlet weak var newPasswordTextField2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeButtonPressed(_ sender: UIButton) {
        guard let old = oldPasswordTextField.text
            ,let new1 = newPasswordTextField1.text
            ,let new2 = newPasswordTextField2.text else {
            return
        }
        
        //비밀번호들을 확인하는 로직
        if new1 != new2 {
            showAlert(style: .alert, message: "비밀번호가 일치하지 않아요", type: "failure")
        } else if isValidPassword(password: new1) == false {
            showAlert(style: .alert, message: "새 비밀번호는 영문, 숫자, 특수문자를 조합해서 만들어 주세요", type: "failure")
        } else {
        
            let changePassword = ChangePassword(old_password: old, new_password1: new1, new_password2: new2)
            
            AF.request("\(K.API_BASE_URL)auth/password/change/",
                       method: .post,
                       parameters: changePassword,
                       encoder: JSONParameterEncoder(), headers: ["Authorization" : self.token])
                    .responseJSON { response in
                        debugPrint(response.response?.statusCode)
                        switch response.response?.statusCode {
                        case 200:
                            self.showAlert(style: .alert, message: "비밀번호 변경 성공\n\n새 비밀번호로 다시 로그인해주세요", type: "success")
                            break
                        case 400:
                            self.showAlert(style: .alert, message: "비밀번호를 확인해주세요", type: "failure")
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
        self.oldPasswordTextField.becomeFirstResponder()
    }
    
    // 키보드 밖을 클릭하면 키보드가 내려가도록 세팅
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.oldPasswordTextField.resignFirstResponder()
        self.newPasswordTextField1.resignFirstResponder()
        self.newPasswordTextField2.resignFirstResponder()
    }
    
    private func setUI() {
        oldPasswordTextField.underlined()
        newPasswordTextField1.underlined()
        newPasswordTextField2.underlined()
    }
    
    private func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //비밀번호 변경 후에는 로그인 화면으로 이동
        if UserDefaults.standard.string(forKey: "username") == nil {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    
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
            self.resetDefaults()
            UserDefaults.standard.set(false, forKey: "runFirst")
            
            self.dismiss(animated: true, completion: nil)
        })
        success.setValue(UIColor(rgb: K.brownColor), forKey: "titleTextColor")
        
        let failure = UIAlertAction(title: "확인", style: .default, handler: nil)
        failure.setValue(UIColor(rgb: K.brownColor), forKey: "titleTextColor")
        
        if type == "success" {
            alert.addAction(success)
        } else if type == "failure" {
            alert.addAction(failure)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension PasswordEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == oldPasswordTextField {
            newPasswordTextField1.becomeFirstResponder()
        } else if textField == newPasswordTextField1 {
            newPasswordTextField2.becomeFirstResponder()
        } else {
            newPasswordTextField2.resignFirstResponder()
        }
        return true
    }
}